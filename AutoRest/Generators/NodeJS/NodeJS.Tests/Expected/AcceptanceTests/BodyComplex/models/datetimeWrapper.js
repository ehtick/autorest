/*
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See License.txt in the project root for
 * license information.
 * 
 * Code generated by Microsoft (R) AutoRest Code Generator 0.14.0.0
 * Changes may cause incorrect behavior and will be lost if the code is
 * regenerated.
 */

'use strict';

/**
 * @class
 * Initializes a new instance of the DatetimeWrapper class.
 * @constructor
 * @member {date} [field]
 * 
 * @member {date} [now]
 * 
 */
function DatetimeWrapper() {
}

/**
 * Defines the metadata of DatetimeWrapper
 *
 * @returns {object} metadata of DatetimeWrapper
 *
 */
DatetimeWrapper.prototype.mapper = function () {
  return {
    required: false,
    serializedName: 'datetime-wrapper',
    type: {
      name: 'Composite',
      className: 'DatetimeWrapper',
      modelProperties: {
        field: {
          required: false,
          serializedName: 'field',
          type: {
            name: 'DateTime'
          }
        },
        now: {
          required: false,
          serializedName: 'now',
          type: {
            name: 'DateTime'
          }
        }
      }
    }
  };
};

module.exports = DatetimeWrapper;