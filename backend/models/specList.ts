import walk from "walk";
import path from "path";

export interface SpecListing {
  endpoint: string;
  method: string;
  name: string;
  description?: string;
}
export default class SpecList {

  private specList: Array<ApiFirstSpec.Api> = [];
  private baseDir: string;

  constructor(dir: string) {
    this.baseDir = path.normalize(dir);
    if (!this.baseDir.endsWith("/")) {
      this.baseDir += "/";
    }
    this.load();
  }

  public load() {
    this.specList = [];
    const walker = walk.walk(this.baseDir.substring(0, this.baseDir.length - 1), {
      followLink: false
    });
    walker.on("file", (root: string, stat: any, next: () => void) => {
      if (stat.name.endsWith(".spec.js")) {
        const path = `${root}/${stat.name}`;
        const api = require(path);
        this.specList.push(api);
      }
      next();
    });
  }

  public list() {
    return this.specList.map(v => {
      return {
        endpoint: v.endpoint,
        method: v.method,
        name: v.name,
        description: v.description
      };
    });
  }

  public get(method: string, endpoint: string) {
    return this.specList.find(v => v.method === method && v.endpoint === endpoint);
  }

}

