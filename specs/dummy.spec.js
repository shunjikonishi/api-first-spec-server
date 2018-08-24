"use strict";
var spec = require("api-first-spec");

var API = spec.define({
  "endpoint": "/api/specs",
  "method": "POST",
  "request": {
    "contentType": spec.ContentType.JSON,
    "headers": {
      "X-Requested-With": "codecheck"
    },
    "params": {
      "token": "string",
      "name": "string",
      "password": "string",
      "imageUrl": "string",
      "language": "string"
    },
  },
  "response": {
    "strict": true,
    "contentType": spec.ContentType.JSON,
    "data": {
      "code": "int",
      "messages": ["string"],
      "result": {
        "id": "number",
        "name": "string"
      }
    },
    "rules": {
      "code": {
        "list": [200],
        "required": true
      },
      "result": {
        "required": function(data) {
          return data.code === 200;
        }
      }
    }
  }
});

module.exports = API;
