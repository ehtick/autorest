// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Storage;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface SkusOperationGroup {
  /**
   * Lists the available SKUs supported by Microsoft.Storage for given subscription.
   */
  @autoRoute
  @get
  @action("skus")
  list is ArmProviderActionSync<
    Response = StorageSkuListResult,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface StorageAccountsOperationGroup {
  /**
   * Checks that the storage account name is valid and is not already in use.
   */
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = StorageAccountCheckNameAvailabilityParameters,
    Response = CheckNameAvailabilityResult,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface DeletedAccountsOperationGroup {
  /**
   * Lists deleted accounts under the subscription.
   */
  @autoRoute
  @get
  @action("deletedAccounts")
  list is ArmProviderActionSync<
    Response = ResourceListResult<DeletedAccount>,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface UsagesOperationGroup {
  /**
   * Gets the current usage count and the limit for the resources of the location under the subscription.
   */
  @autoRoute
  @get
  @action("usages")
  listByLocation is ArmProviderActionSync<
    Response = UsageListResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}
