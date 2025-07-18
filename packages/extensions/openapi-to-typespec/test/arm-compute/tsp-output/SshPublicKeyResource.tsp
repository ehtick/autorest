import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Compute;
/**
 * Specifies information about the SSH public key.
 */
model SshPublicKeyResource
  is Azure.ResourceManager.TrackedResource<SshPublicKeyResourceProperties> {
  ...ResourceNameParameter<
    Resource = SshPublicKeyResource,
    KeyName = "sshPublicKeyName",
    SegmentName = "sshPublicKeys",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SshPublicKeyResources {
  /**
   * Retrieves information about an SSH public key.
   */
  get is ArmResourceRead<SshPublicKeyResource>;

  /**
   * Creates a new SSH public key resource.
   */
  create is ArmResourceCreateOrReplaceSync<SshPublicKeyResource>;

  /**
   * Updates a new SSH public key resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    SshPublicKeyResource,
    PatchModel = SshPublicKeyUpdateResource
  >;

  /**
   * Delete an SSH public key.
   */
  delete is ArmResourceDeleteSync<SshPublicKeyResource>;

  /**
   * Lists all of the SSH public keys in the specified resource group. Use the nextLink property in the response to get the next page of SSH public keys.
   */
  listByResourceGroup is ArmResourceListByParent<SshPublicKeyResource>;

  /**
   * Lists all of the SSH public keys in the subscription. Use the nextLink property in the response to get the next page of SSH public keys.
   */
  listBySubscription is ArmListBySubscription<SshPublicKeyResource>;

  /**
   * Generates and returns a public/private key pair and populates the SSH public key resource with the public key. The length of the key will be 3072 bits. This operation can only be performed once per SSH public key resource.
   */
  generateKeyPair is ArmResourceActionSync<
    SshPublicKeyResource,
    void,
    ArmResponse<SshPublicKeyGenerateKeyPairResult>
  >;
}

@@doc(SshPublicKeyResource.name, "The name of the SSH public key.");
@@doc(SshPublicKeyResource.properties, "Properties of the SSH public key.");
@@doc(SshPublicKeyResources.create::parameters.resource,
  "Parameters supplied to create the SSH public key."
);
@@doc(SshPublicKeyResources.update::parameters.properties,
  "Parameters supplied to update the SSH public key."
);
