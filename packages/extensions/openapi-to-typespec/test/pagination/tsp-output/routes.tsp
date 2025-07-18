import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace AutoRestPagingTestService;

interface PagingOperationGroup {
  /**
   * A paging operation that must return result of the default 'value' node.
   */
  @operationId("Paging_getNoItemNamePages")
  @route("/paging/noitemname")
  @get
  getNoItemNamePages is Azure.Core.Foundations.Operation<
    {},
    ProductResultValue
  >;

  /**
   * A paging operation that must ignore any kind of nextLink, and stop after page 1.
   */
  @operationId("Paging_getNullNextLinkNamePages")
  @route("/paging/nullnextlink")
  @get
  getNullNextLinkNamePages is Azure.Core.Foundations.Operation<
    {},
    ProductResult
  >;

  /**
   * A paging operation that finishes on the first call without a nextlink
   */
  @operationId("Paging_getSinglePages")
  @route("/paging/single")
  @get
  getSinglePages is Azure.Core.Foundations.Operation<{}, ProductResult>;

  /**
   * A paging operation whose first response's items list is empty, but still
   * returns a next link. Second (and final) call, will give you an items list of 1.
   */
  @operationId("Paging_firstResponseEmpty")
  @route("/paging/firstResponseEmpty/1")
  @get
  firstResponseEmpty is Azure.Core.Foundations.Operation<
    {},
    ProductResultValue
  >;

  /**
   * A paging operation that includes a nextLink that has 10 pages
   */
  @operationId("Paging_getMultiplePages")
  @route("/paging/multiple")
  @get
  getMultiplePages is Azure.Core.Foundations.Operation<
    {
      @header
      `client-request-id`?: string;

      /**
       * Sets the maximum number of items to return in the response.
       */
      @header
      maxresults?: int32;

      /**
       * Sets the maximum time that the server can spend processing the request, in
       * seconds. The default is 30 seconds.
       */
      @header
      timeout?: int32 = 30;
    },
    ProductResult
  >;

  /**
   * A paging operation that includes a next operation. It has a different query
   * parameter from it's next operation nextOperationWithQueryParams. Returns a
   * ProductResult
   */
  @operationId("Paging_getWithQueryParams")
  @route("/paging/multiple/getWithQueryParams")
  @get
  getWithQueryParams is Azure.Core.Foundations.Operation<
    {
      /**
       * A required integer query parameter. Put in value '100' to pass test.
       */
      @query("requiredQueryParameter")
      requiredQueryParameter: int32;

      /**
       * A constant. Must be True and will be passed as a query parameter to
       * nextOperationWithQueryParams
       */
      @query("queryConstant")
      queryConstant: true;
    },
    ProductResult
  >;

  /**
   * Define `filter` as a query param for all calls. However, the returned next link
   * will also include the `filter` as part of it. Make sure you don't end up
   * duplicating the `filter` param in the url sent.
   */
  @operationId("Paging_duplicateParams")
  @route("/paging/multiple/duplicateParams/1")
  @get
  duplicateParams is Azure.Core.Foundations.Operation<
    {
      /**
       * OData filter options. Pass in 'foo'
       */
      @query("$filter")
      $filter?: string;
    },
    ProductResult
  >;

  /**
   * Paging with max page size. We don't want to
   */
  @operationId("Paging_pageWithMaxPageSize")
  @route("/paging/maxPageSize")
  @get
  pageWithMaxPageSize is Azure.Core.Foundations.Operation<
    {
      /**
       * Max page size query param. Don't send
       */
      @query("$maxpagesize")
      $maxpagesize?: "5";
    },
    ProductResult
  >;

  /**
   * Next operation for getWithQueryParams. Pass in next=True to pass test. Returns
   * a ProductResult
   */
  @operationId("Paging_nextOperationWithQueryParams")
  @route("/paging/multiple/nextOperationWithQueryParams")
  @get
  nextOperationWithQueryParams is Azure.Core.Foundations.Operation<
    {
      /**
       * A constant. Must be True
       */
      @query("queryConstant")
      queryConstant: true;
    },
    ProductResult
  >;

  /**
   * A paging operation that includes a nextLink in odata format that has 10 pages
   */
  @operationId("Paging_getOdataMultiplePages")
  @route("/paging/multiple/odata")
  @get
  getOdataMultiplePages is Azure.Core.Foundations.Operation<
    {
      @header
      `client-request-id`?: string;

      /**
       * Sets the maximum number of items to return in the response.
       */
      @header
      maxresults?: int32;

      /**
       * Sets the maximum time that the server can spend processing the request, in
       * seconds. The default is 30 seconds.
       */
      @header
      timeout?: int32 = 30;
    },
    OdataProductResult
  >;

  /**
   * A paging operation that includes a nextLink that has 10 pages
   */
  @operationId("Paging_getMultiplePagesWithOffset")
  @route("/paging/multiple/withpath/{offset}")
  @get
  getMultiplePagesWithOffset is Azure.Core.Foundations.Operation<
    {
      @header
      `client-request-id`?: string;

      /**
       * Sets the maximum number of items to return in the response.
       */
      @header
      maxresults?: int32;

      /**
       * Offset of return value
       */
      @path
      offset: int32;

      /**
       * Sets the maximum time that the server can spend processing the request, in
       * seconds. The default is 30 seconds.
       */
      @header
      timeout?: int32 = 30;
    },
    ProductResult
  >;

  /**
   * A paging operation that fails on the first call with 500 and then retries and
   * then get a response including a nextLink that has 10 pages
   */
  @operationId("Paging_getMultiplePagesRetryFirst")
  @route("/paging/multiple/retryfirst")
  @get
  getMultiplePagesRetryFirst is Azure.Core.Foundations.Operation<
    {},
    ProductResult
  >;

  /**
   * A paging operation that includes a nextLink that has 10 pages, of which the 2nd
   * call fails first with 500. The client should retry and finish all 10 pages
   * eventually.
   */
  @operationId("Paging_getMultiplePagesRetrySecond")
  @route("/paging/multiple/retrysecond")
  @get
  getMultiplePagesRetrySecond is Azure.Core.Foundations.Operation<
    {},
    ProductResult
  >;

  /**
   * A paging operation that receives a 400 on the first call
   */
  @operationId("Paging_getSinglePagesFailure")
  @route("/paging/single/failure")
  @get
  getSinglePagesFailure is Azure.Core.Foundations.Operation<{}, ProductResult>;

  /**
   * A paging operation that receives a 400 on the second call
   */
  @operationId("Paging_getMultiplePagesFailure")
  @route("/paging/multiple/failure")
  @get
  getMultiplePagesFailure is Azure.Core.Foundations.Operation<
    {},
    ProductResult
  >;

  /**
   * A paging operation that receives an invalid nextLink
   */
  @operationId("Paging_getMultiplePagesFailureUri")
  @route("/paging/multiple/failureuri")
  @get
  getMultiplePagesFailureUri is Azure.Core.Foundations.Operation<
    {},
    ProductResult
  >;

  /**
   * A paging operation that doesn't return a full URL, just a fragment
   */
  @operationId("Paging_getMultiplePagesFragmentNextLink")
  @route("/paging/multiple/fragment/{tenant}")
  @get
  getMultiplePagesFragmentNextLink is Azure.Core.Foundations.Operation<
    {
      /**
       * Sets the api version to use.
       */
      @query("api_version")
      api_version: string;

      /**
       * Sets the tenant to use.
       */
      @path
      tenant: string;
    },
    OdataProductResult
  >;

  /**
   * A paging operation that doesn't return a full URL, just a fragment with
   * parameters grouped
   */
  @operationId("Paging_getMultiplePagesFragmentWithGroupingNextLink")
  @route("/paging/multiple/fragmentwithgrouping/{tenant}")
  @get
  getMultiplePagesFragmentWithGroupingNextLink is Azure.Core.Foundations.Operation<
    {
      /**
       * Sets the api version to use.
       */
      @query("api_version")
      api_version: string;

      /**
       * Sets the tenant to use.
       */
      @path
      tenant: string;
    },
    OdataProductResult
  >;

  /**
   * A long-running paging operation that includes a nextLink that has 10 pages
   */
  @route("/paging/multiple/lro")
  @post
  getMultiplePagesLRO is Azure.Core.Foundations.Operation<
    {
      @header
      `client-request-id`?: string;

      /**
       * Sets the maximum number of items to return in the response.
       */
      @header
      maxresults?: int32;

      /**
       * Sets the maximum time that the server can spend processing the request, in
       * seconds. The default is 30 seconds.
       */
      @header
      timeout?: int32 = 30;
    },
    ProductResult
  >;

  /**
   * A paging operation with api version. When calling the next link, you want to
   * append your client's api version to the next link
   */
  @operationId("Paging_appendApiVersion")
  @route("/paging/apiVersion/append/1")
  @get
  appendApiVersion is Azure.Core.Foundations.Operation<{}, ProductResult>;

  /**
   * A paging operation with api version. When calling the next link, you want to
   * reformat it and override the returned api version with your client's api
   * version
   */
  @operationId("Paging_replaceApiVersion")
  @route("/paging/apiVersion/replace/1")
  @get
  replaceApiVersion is Azure.Core.Foundations.Operation<{}, ProductResult>;

  /**
   * A paging operation that doesn't return a full URL, just a fragment
   */
  @operationId("Paging_nextFragment")
  @route("/paging/multiple/fragment/{tenant}/{nextLink}")
  @get
  nextFragment is Azure.Core.Foundations.Operation<
    {
      /**
       * Sets the api version to use.
       */
      @query("api_version")
      api_version: string;

      /**
       * Sets the tenant to use.
       */
      @path
      tenant: string;

      /**
       * Next link for list operation.
       */
      @path
      nextLink: string;
    },
    OdataProductResult
  >;

  /**
   * A paging operation that doesn't return a full URL, just a fragment
   */
  @operationId("Paging_nextFragmentWithGrouping")
  @route("/paging/multiple/fragmentwithgrouping/{tenant}/{nextLink}")
  @get
  nextFragmentWithGrouping is Azure.Core.Foundations.Operation<
    {
      /**
       * Sets the api version to use.
       */
      @query("api_version")
      api_version: string;

      /**
       * Sets the tenant to use.
       */
      @path
      tenant: string;

      /**
       * Next link for list operation.
       */
      @path
      nextLink: string;
    },
    OdataProductResult
  >;

  /**
   * A paging operation that returns a paging model whose item name is is overriden
   * by x-ms-client-name 'indexes'.
   */
  @operationId("Paging_getPagingModelWithItemNameWithXMSClientName")
  @route("/paging/itemNameWithXMSClientName")
  @get
  getPagingModelWithItemNameWithXMSClientName is Azure.Core.Foundations.Operation<
    {},
    ProductResultValueWithXMSClientName
  >;
}
