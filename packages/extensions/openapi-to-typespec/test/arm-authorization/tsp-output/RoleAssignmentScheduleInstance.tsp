import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.ResourceManager.Authorization;
/**
 * Information about current or upcoming role assignment schedule instance
 */
@extensionResource
model RoleAssignmentScheduleInstance
  is Azure.ResourceManager.ExtensionResource<RoleAssignmentScheduleInstanceProperties> {
  ...ResourceNameParameter<
    Resource = RoleAssignmentScheduleInstance,
    KeyName = "roleAssignmentScheduleInstanceName",
    SegmentName = "roleAssignmentScheduleInstances",
    NamePattern = ""
  >;
}

@armResourceOperations
interface RoleAssignmentScheduleInstances {
  /**
   * Gets the specified role assignment schedule instance.
   */
  get is ArmResourceRead<
    RoleAssignmentScheduleInstance,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Parameters = {
      /**
       * The scope of the role assignments schedules.
       */
      @path
      scope: string;

      /**
       * The name (hash of schedule name + time) of the role assignment schedule to get.
       */
      @path
      roleAssignmentScheduleInstanceName: string;
    }
  >;

  /**
   * Gets role assignment schedule instances of a role assignment schedule.
   */
  listForScope is ArmResourceListByParent<
    RoleAssignmentScheduleInstance,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Parameters = {
      /**
       * The scope of the role assignment schedule.
       */
      @path
      scope: string;

      /**
       * The filter to apply on the operation. Use $filter=atScope() to return all role assignment schedules at or above the scope. Use $filter=principalId eq {id} to return all role assignment schedules at, above or below the scope for the specified principal.  Use $filter=assignedTo('{userId}') to return all role assignment schedule instances for the user. Use $filter=asTarget() to return all role assignment schedule instances created for the current user.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@doc(RoleAssignmentScheduleInstance.name,
  "The name (hash of schedule name + time) of the role assignment schedule to get."
);
@@doc(RoleAssignmentScheduleInstance.properties,
  "Role assignment schedule instance properties."
);
