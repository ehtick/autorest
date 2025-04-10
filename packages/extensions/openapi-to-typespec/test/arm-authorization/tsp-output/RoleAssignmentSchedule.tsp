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
 * Role Assignment schedule
 */
@extensionResource
model RoleAssignmentSchedule
  is Azure.ResourceManager.ExtensionResource<RoleAssignmentScheduleProperties> {
  ...ResourceNameParameter<
    Resource = RoleAssignmentSchedule,
    KeyName = "roleAssignmentScheduleName",
    SegmentName = "roleAssignmentSchedules",
    NamePattern = ""
  >;
}

@armResourceOperations
interface RoleAssignmentSchedules {
  /**
   * Get the specified role assignment schedule for a resource scope
   */
  get is ArmResourceRead<
    RoleAssignmentSchedule,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Parameters = {
      /**
       * The scope of the role assignment schedule.
       */
      @path
      scope: string;

      /**
       * The name (guid) of the role assignment schedule to get.
       */
      @path
      roleAssignmentScheduleName: string;
    }
  >;

  /**
   * Gets role assignment schedules for a resource scope.
   */
  listForScope is ArmResourceListByParent<
    RoleAssignmentSchedule,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Parameters = {
      /**
       * The scope of the role assignments schedules.
       */
      @path
      scope: string;

      /**
       * The filter to apply on the operation. Use $filter=atScope() to return all role assignment schedules at or above the scope. Use $filter=principalId eq {id} to return all role assignment schedules at, above or below the scope for the specified principal. Use $filter=assignedTo('{userId}') to return all role assignment schedules for the current user. Use $filter=asTarget() to return all role assignment schedules created for the current user.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@doc(RoleAssignmentSchedule.name,
  "The name (guid) of the role assignment schedule to get."
);
@@doc(RoleAssignmentSchedule.properties,
  "Role assignment schedule properties."
);
