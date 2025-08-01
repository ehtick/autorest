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
 * Specifies information about the Shared Image Gallery that you want to create or update.
 */
model Gallery is Azure.ResourceManager.TrackedResource<GalleryProperties> {
  ...ResourceNameParameter<
    Resource = Gallery,
    KeyName = "galleryName",
    SegmentName = "galleries",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Galleries {
  /**
   * Retrieves information about a Shared Image Gallery.
   */
  get is ArmResourceRead<
    Gallery,
    Parameters = {
      /**
       * The select expression to apply on the operation.
       */
      @query("$select")
      $select?: SelectPermissions;

      /**
       * The expand query option to apply on the operation.
       */
      @query("$expand")
      $expand?: GalleryExpandParams;
    }
  >;

  /**
   * Create or update a Shared Image Gallery.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Gallery,
    Response = ArmResourceUpdatedResponse<Gallery> | ArmResourceCreatedResponse<
      Gallery,
      ArmLroLocationHeader<FinalResult = Gallery> &
        Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: Gallery;
    })
  >;

  /**
   * Update a Shared Image Gallery.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Gallery,
    PatchModel = GalleryUpdate,
    Response = ArmResponse<Gallery>
  >;

  /**
   * Delete a Shared Image Gallery.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Gallery,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List galleries under a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Gallery,
    Response = ArmResponse<GalleryList>
  >;

  /**
   * List galleries under a subscription.
   */
  list is ArmListBySubscription<Gallery, Response = ArmResponse<GalleryList>>;

  /**
   * Update sharing profile of a gallery.
   */
  @action("share")
  gallerySharingProfileUpdate is ArmResourceActionAsync<
    Gallery,
    SharingUpdate,
    ArmResponse<SharingUpdate>
  >;
}

@@doc(Gallery.name, "The name of the Shared Image Gallery.");
@@doc(Gallery.properties,
  "Describes the properties of a Shared Image Gallery."
);
@@doc(Galleries.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update Shared Image Gallery operation."
);
@@doc(Galleries.update::parameters.properties,
  "Parameters supplied to the update Shared Image Gallery operation."
);
@@doc(Galleries.gallerySharingProfileUpdate::parameters.body,
  "Parameters supplied to the update gallery sharing profile."
);
