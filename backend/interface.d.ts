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
    contentType?: string;
    headers?: any;
    params?: any;
    rules?: any;
  }

  interface ResponseConfig {
    strict: boolean;
    contentType?: string;
    data: any;
    rules: any;
  }

  interface Api extends ApiConfig {
    name: string;
  }
}

declare module "api-first-spec" {
  export function define(config: ApiFirstSpec.ApiConfig): ApiFirstSpec.Api;
  export function skipTest(): boolean;
  export function skipTest(v: boolean): void;
  export function verbose(): boolean;
  export function verbose(v: boolean): void;
}


