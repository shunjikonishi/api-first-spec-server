declare module "walk" {
  var module: any;
  export = module;
}

declare namespace ApiFirstSpec {

  interface ApiConfig {
    name?: string;
    description?: string;
    endpoint: string;
    method: string;
    request: RequestConfig;
    response: ResponseConfig;
  }

  interface RequestConfig {
    strict?: boolean;
    contentType?: string;
    headers?: any;
    params?: any;
    rules?: any;
  }

  interface ResponseConfig {
    strict?: boolean;
    contentType?: string;
    data: any;
    rules: any;
  }

  interface Rule {
    name: string;
    param: any;
  }

  interface Param {
    name: string;
    type: string;
    isArray: boolean;
    rules: Array<Rule>;
    hasChildren(): boolean;
    childNames(): Array<string>;
    hasRule(name: string): boolean;
    getChild(name: string): Param;
  }

  interface Request {
    strict: boolean;
    contentType: string;
    headers?: any;
    params?: Param;
  }

  interface Response {
    strict: boolean;
    contentType: string;
    headers?: any;
    data?: Param;
  }

  interface Api {
    filepath?: string;
    name: string;
    description?: string;
    endpoint: string;
    method: string;
    urlParams?: Array<string>;
    request: Request;
    response: Response;
  }
}

interface SerializedParam {
  name: string;
  type: string;
  isArray: boolean;
  rules?: Array<ApiFirstSpec.Rule>;
  children?: SerializedParamHolder;
}

interface SerializedParamHolder {
  [key: string]: SerializedParam;
}

interface SerializedRequest {
  strict: boolean;
  contentType: string;
  headers?: any;
  params?: SerializedParamHolder;
}

interface SerializedResponse {
  strict: boolean;
  contentType: string;
  headers?: any;
  data?: SerializedParamHolder;
}

interface SerializedApi {
  name: string;
  description?: string;
  endpoint: string;
  method: string;
  urlParams?: Array<string>;
  request: SerializedRequest;
  response: SerializedResponse;
}

declare module "api-first-spec" {
  export function define(config: ApiFirstSpec.ApiConfig): ApiFirstSpec.Api;
  export function skipTest(): boolean;
  export function skipTest(v: boolean): void;
  export function verbose(): boolean;
  export function verbose(v: boolean): void;
}


