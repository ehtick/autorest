import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.IntegrationSpaces;

/**
 * The intended executor of the operation; as in Resource Based Access Control (RBAC) and audit logs UX. Default value is "user,system"
 */
union Origin {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  user: "user",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  system: "system",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `user,system`: "user,system",
}

/**
 * Enum. Indicates the action type. "Internal" refers to actions that are for internal only APIs.
 */
union ActionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Internal: "Internal",
}

/**
 * The status of the current operation.
 */
union ProvisioningState {
  string,

  /**
   * Resource has been created.
   */
  Succeeded: "Succeeded",

  /**
   * Resource creation failed.
   */
  Failed: "Failed",

  /**
   * Resource creation was canceled.
   */
  Canceled: "Canceled",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Accepted: "Accepted",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Key: "Key",
}

/**
 * Localized display information for this particular operation.
 */
model OperationDisplay {
  /**
   * The localized friendly form of the resource provider name, e.g. "Microsoft Monitoring Insights" or "Microsoft Compute".
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * The localized friendly name of the resource type related to this operation. E.g. "Virtual Machines" or "Job Schedule Collections".
   */
  @visibility(Lifecycle.Read)
  resource?: string;

  /**
   * The concise, localized friendly name for the operation; suitable for dropdowns. E.g. "Create or Update Virtual Machine", "Restart Virtual Machine".
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The short, localized friendly description of the operation; suitable for tool tips and detailed views.
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * The properties of space.
 */
model SpaceResourceProperties {
  /**
   * The status of the last operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The description of the resource.
   */
  description?: string;
}

/**
 * The type used for update operations of the Space.
 */
model SpaceUpdate {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * The updatable properties of the Space.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: SpaceUpdateProperties;
}

/**
 * The updatable properties of the Space.
 */
model SpaceUpdateProperties {
  /**
   * The description of the resource.
   */
  description?: string;
}

/**
 * The properties of application.
 */
model ApplicationProperties {
  /**
   * The status of the last operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The description of the resource.
   */
  description?: string;

  /**
   * The tracking data stores.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  trackingDataStores: Record<TrackingDataStore>;
}

/**
 * The properties of tracking data store.
 */
model TrackingDataStore {
  /**
   * The database name.
   */
  databaseName: string;

  /**
   * The data store resource id.
   */
  dataStoreResourceId: string;

  /**
   * The data store URI.
   */
  dataStoreUri: string;

  /**
   * The data store ingestion URI.
   */
  dataStoreIngestionUri: string;
}

/**
 * The type used for update operations of the Application.
 */
model ApplicationUpdate {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * The updatable properties of the Application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ApplicationUpdateProperties;
}

/**
 * The updatable properties of the Application.
 */
model ApplicationUpdateProperties {
  /**
   * The description of the resource.
   */
  description?: string;

  /**
   * The tracking data stores.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  trackingDataStores?: Record<TrackingDataStore>;
}

/**
 * The properties of business process.
 */
model BusinessProcessProperties {
  /**
   * The status of the last operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The version of the business process.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * The description of the business process.
   */
  description?: string;

  /**
   * The table name of the business process.
   */
  tableName?: string;

  /**
   * The tracking data store reference name.
   */
  trackingDataStoreReferenceName?: string;

  /**
   * The business process identifier.
   */
  identifier?: BusinessProcessIdentifier;

  /**
   * The business process stages.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  businessProcessStages?: Record<BusinessProcessStage>;

  /**
   * The business process mapping.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  businessProcessMapping?: Record<BusinessProcessMappingItem>;
}

/**
 * The properties of business process identifier.
 */
model BusinessProcessIdentifier {
  /**
   * The property name of the business process identifier.
   */
  propertyName?: string;

  /**
   * The property type of the business process identifier.
   */
  propertyType?: string;
}

/**
 * The properties of business process stage.
 */
model BusinessProcessStage {
  /**
   * The description of the business stage.
   */
  description?: string;

  /**
   * The properties within the properties of the business process stage.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  properties?: Record<string>;

  /**
   * The property to keep track of stages before current in the business process stage.
   */
  stagesBefore?: string[];
}

/**
 * The properties of business process mapping.
 */
model BusinessProcessMappingItem {
  /**
   * The logic app resource id.
   */
  logicAppResourceId?: string;

  /**
   * The workflow name within the logic app.
   */
  workflowName?: string;

  /**
   * The operation name.
   */
  operationName?: string;

  /**
   * The mapping item operation type of the business process.
   */
  operationType?: string;
}

/**
 * The type used for update operations of the BusinessProcess.
 */
model BusinessProcessUpdate {
  /**
   * The updatable properties of the BusinessProcess.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: BusinessProcessUpdateProperties;
}

/**
 * The updatable properties of the BusinessProcess.
 */
model BusinessProcessUpdateProperties {
  /**
   * The description of the business process.
   */
  description?: string;

  /**
   * The table name of the business process.
   */
  tableName?: string;

  /**
   * The tracking data store reference name.
   */
  trackingDataStoreReferenceName?: string;

  /**
   * The business process identifier.
   */
  identifier?: BusinessProcessIdentifier;

  /**
   * The business process stages.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  businessProcessStages?: Record<BusinessProcessStage>;

  /**
   * The business process mapping.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  businessProcessMapping?: Record<BusinessProcessMappingItem>;
}

/**
 * The business process development artifact get or delete request.
 */
model GetOrDeleteBusinessProcessDevelopmentArtifactRequest {
  /**
   * The name of the business process development artifact.
   */
  name: string;
}

/**
 * The business process development artifact save or get response.
 */
model SaveOrGetBusinessProcessDevelopmentArtifactResponse {
  /**
   * The name of the business process development artifact.
   */
  name: string;

  /**
   * The system data of the business process development artifact.
   */
  systemData?: BusinessProcessDevelopmentArtifactSystemData;

  /**
   * The properties of the business process development artifact.
   */
  properties?: BusinessProcessDevelopmentArtifactProperties;
}

/**
 * The system data for business process development artifact.
 */
model BusinessProcessDevelopmentArtifactSystemData {
  /**
   * The timestamp of last modification (UTC).
   */
  lastModifiedAt?: string;
}

/**
 * The properties of business process development artifact.
 */
model BusinessProcessDevelopmentArtifactProperties {
  /**
   * The description of the business process.
   */
  description?: string;

  /**
   * The business process identifier.
   */
  identifier?: BusinessProcessIdentifier;

  /**
   * The business process stages.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  businessProcessStages?: Record<BusinessProcessStage>;

  /**
   * The business process mapping.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  businessProcessMapping?: Record<BusinessProcessMappingItem>;

  /**
   * The tracking profile for the business process.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  trackingProfiles?: Record<TrackingProfileDefinition>;
}

/**
 * The tracking profile for the business process
 */
model TrackingProfileDefinition {
  /**
   * The tracking definition schema uri.
   */
  $schema?: string;

  /**
   * The business process reference.
   */
  businessProcess?: BusinessProcessReference;

  /**
   * The tracking definitions.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  trackingDefinitions?: Record<FlowTrackingDefinition>;
}

/**
 * The business process reference.
 */
model BusinessProcessReference {
  /**
   * The business process name.
   */
  name?: string;

  /**
   * The business process version.
   */
  version?: string;
}

/**
 * The workflow tracking definition.
 */
model FlowTrackingDefinition {
  /**
   * The tracking correlation context.
   */
  correlationContext?: TrackingCorrelationContext;

  /**
   * The tracking events.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  events?: Record<TrackingEventDefinition>;
}

/**
 * The tracking correlation context.
 */
model TrackingCorrelationContext {
  /**
   * The operation type for correlation context.
   */
  operationType?: string;

  /**
   * The operation name for correlation context.
   */
  operationName?: string;

  /**
   * The name of the correlation property.
   */
  propertyName?: string;

  /**
   * The template expression for correlation context property value.
   */
  value?: string;
}

/**
 * The tracking event definition.
 */
model TrackingEventDefinition {
  /**
   * The operation type.
   */
  operationType?: string;

  /**
   * The operation name.
   */
  operationName?: string;

  /**
   * The properties to be collected for event.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  properties?: Record<Record<unknown>>;
}

/**
 * The business process development artifact get collection response.
 */
model ListBusinessProcessDevelopmentArtifactsResponse {
  /**
   * The list of the business process development artifact.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  value: SaveOrGetBusinessProcessDevelopmentArtifactResponse[];
}

/**
 * The properties of application resource.
 */
model ApplicationResourceProperties {
  /**
   * The status of the last operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The type of the application resource.
   */
  resourceType: string;

  /**
   * The Arm id of the application resource.
   */
  resourceId: string;

  /**
   * The kind of the application resource.
   */
  resourceKind?: string;
}

/**
 * The type used for update operations of the ApplicationResource.
 */
model ApplicationResourceUpdate {
  /**
   * The updatable properties of the ApplicationResource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ApplicationResourceUpdateProperties;
}

/**
 * The updatable properties of the ApplicationResource.
 */
model ApplicationResourceUpdateProperties {
  /**
   * The type of the application resource.
   */
  resourceType?: string;

  /**
   * The Arm id of the application resource.
   */
  resourceId?: string;

  /**
   * The kind of the application resource.
   */
  resourceKind?: string;
}

/**
 * The business process development artifact save or validate request.
 */
model SaveOrValidateBusinessProcessDevelopmentArtifactRequest {
  /**
   * The name of the business process development artifact.
   */
  name: string;

  /**
   * The properties of the business process development artifact.
   */
  properties?: BusinessProcessDevelopmentArtifactProperties;
}

/**
 * The properties of infrastructure resource.
 */
model InfrastructureResourceProperties {
  /**
   * The status of the last operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The type of the infrastructure resource.
   */
  resourceType: string;

  /**
   * The id of the infrastructure resource.
   */
  resourceId: string;
}

/**
 * The type used for update operations of the InfrastructureResource.
 */
model InfrastructureResourceUpdate {
  /**
   * The updatable properties of the InfrastructureResource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: InfrastructureResourceUpdateProperties;
}

/**
 * The updatable properties of the InfrastructureResource.
 */
model InfrastructureResourceUpdateProperties {
  /**
   * The type of the infrastructure resource.
   */
  resourceType?: string;

  /**
   * The id of the infrastructure resource.
   */
  resourceId?: string;
}
