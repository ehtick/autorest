import { TypespecObject } from "../interfaces";
import { getOptions } from "../options";
import { generateDecorators } from "../utils/decorators";
import { generateDocs } from "../utils/docs";
import { getModelPropertiesDeclarations } from "../utils/model-generation";
import { generateSuppressionForDocumentRequired, generateSuppressions } from "../utils/suppressions";

export function generateObject(typespecObject: TypespecObject) {
  const { isFullCompatible } = getOptions();
  let definitions: string[] = [];

  const fixme = getFixme(typespecObject);
  fixme && definitions.push(fixme);

  const doc = generateDocs(typespecObject);
  if (doc === "" && isFullCompatible) definitions.push(generateSuppressionForDocumentRequired());
  definitions.push(doc);

  const decorators = generateDecorators(typespecObject.decorators);
  decorators && definitions.push(decorators);

  typespecObject.suppressions && definitions.push(...generateSuppressions(typespecObject.suppressions));

  if (typespecObject.extendedParents?.length) {
    const firstParent = typespecObject.extendedParents[0];
    definitions.push(`model ${typespecObject.name} extends ${firstParent} {`);
  } else if (typespecObject.alias) {
    const { alias, params } = typespecObject.alias;

    definitions.push(`model ${typespecObject.name} is ${alias}${params ? `<${params.join(",")}>` : ""} {`);
  } else {
    definitions.push(`model ${typespecObject.name} {`);
  }

  if (typespecObject.spreadParents?.length) {
    for (const parent of typespecObject.spreadParents) {
      definitions.push(`...${parent};`);
    }
  }

  definitions = [...definitions, ...getModelPropertiesDeclarations(typespecObject.properties)];
  definitions.push("}");

  return definitions.join("\n");
}

function getFixme(typespecObject: TypespecObject): string | undefined {
  if (!typespecObject.fixMe) {
    return undefined;
  }

  return typespecObject.fixMe.join("\n");
}
