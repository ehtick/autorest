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
 * Role Assignments
 */
@extensionResource
model RoleAssignment
  is Azure.ResourceManager.ExtensionResource<RoleAssignmentProperties> {
  ...ResourceNameParameter<
    Resource = RoleAssignment,
    KeyName = "roleAssignmentName",
    SegmentName = "roleAssignments",
    NamePattern = ""
  >;
}

@armResourceOperations
interface RoleAssignments {
  /**
   * Get a role assignment by scope and name.
   */
  get is Extension.Read<
    Extension.ScopeParameter,
    RoleAssignment,
    Parameters = {
      /**
       * Tenant ID for cross-tenant request
       */
      @query("tenantId")
      tenantId?: string;
    }
  >;

  /**
   * Create or update a role assignment by scope and name.
   */
  create is Extension.CreateOrReplaceSync<
    Extension.ScopeParameter,
    RoleAssignment
  >;

  /**
   * Delete a role assignment by scope and name.
   */
  delete is Extension.DeleteSync<
    Extension.ScopeParameter,
    RoleAssignment,
    Parameters = {
      /**
       * Tenant ID for cross-tenant request
       */
      @query("tenantId")
      tenantId?: string;
    },
    Response = ArmResponse<RoleAssignment> | ArmDeletedNoContentResponse
  >;

  /**
   * List all role assignments that apply to a scope.
   */
  listForScope is Extension.ListByTarget<
    Extension.ScopeParameter,
    RoleAssignment,
    Parameters = {
      /**
       * The filter to apply on the operation. Use $filter=atScope() to return all role assignments at or above the scope. Use $filter=principalId eq {id} to return all role assignments at, above or below the scope for the specified principal.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Tenant ID for cross-tenant request
       */
      @query("tenantId")
      tenantId?: string;

      /**
       * The skipToken to apply on the operation. Use $skipToken={skiptoken} to return paged role assignments following the skipToken passed. Only supported on provider level calls.
       */
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
}

@@doc(RoleAssignment.name,
  "The name of the role assignment. It can be any valid GUID."
);
@@doc(RoleAssignment.properties, "Role assignment properties.");
@@doc(RoleAssignments.create::parameters.resource,
  "Parameters for the role assignment."
);
