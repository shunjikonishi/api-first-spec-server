export default class SpecSerializer {
  public serialize(spec: ApiFirstSpec.Api) {
    return this.processApi(spec);
  }

  private processApi(api: ApiFirstSpec.Api) : SerializedApi {
    return {
      filepath: api.filepath || "",
      name: api.name,
      description: api.description,
      endpoint: api.endpoint,
      method: api.method,
      urlParams: api.urlParams,
      request: this.processRequest(api.request),
      response: this.processResponse(api.response)
    };
  }

  private processRequest(request: ApiFirstSpec.Request): SerializedRequest {
    const result: SerializedRequest = {
      strict: !!request.strict,
      contentType: request.contentType,
      headers: request.headers,
    };
    if (request.params && request.params.hasChildren()) {
      result.params = this.processParams(request.params);
    }
    return result;
  }

  private processResponse(response: ApiFirstSpec.Response): SerializedResponse {
    const result: SerializedResponse = {
      strict: !!response.strict,
      contentType: response.contentType,
      headers: response.headers,
    };
    if (response.data && response.data.hasChildren()) {
      result.data = this.processParams(response.data);
    }
    return result;
  }

  private processParams(params: ApiFirstSpec.Param): Array<SerializedParam> {
    const result: Array<SerializedParam> = [];
    params.childNames().forEach(key => {
      const child = params.getChild(key);
      const serializedChild: SerializedParam = {
        name: key,
        type: child.type,
        isArray: child.isArray,
        rules: child.rules.map(v => this.processRule(v))
      };
      if (child.hasChildren()) {
        serializedChild.children = this.processParams(child);
      }
      result.push(serializedChild);
    });
    return result;
  }

  private processRule(rule: ApiFirstSpec.Rule): ApiFirstSpec.Rule {
    const result: ApiFirstSpec.Rule = {
      name: rule.name,
      param: rule.param
    };
    if (rule.name === "list") {
      result.param = "[ " + rule.param.join(", ") + " ]";
    } else if (typeof rule.param !== "string") {
      result.param = rule.param.toString();
    }
    return result;
  }
}