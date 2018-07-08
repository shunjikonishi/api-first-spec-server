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

  public load(): Promise<Array<ApiFirstSpec.Api>> {
    this.specList = [];
    return new Promise(resolve => {
      const walker = walk.walk(this.baseDir.substring(0, this.baseDir.length - 1), {
        followLink: false
      });
      walker.on("file", (root: string, stat: any, next: () => void) => {
        if (stat.name.endsWith(".spec.js")) {
          const path = `${root}/${stat.name}`;
          const api = require(path);
          api.filepath = path.substring(this.baseDir.length - 1);
          this.specList.push(api);
        }
        next();
      });
      walker.on("end", () => {
        resolve(this.specList);
      });
    });
  }

  public list() {
    return this.specList.map(v => {
      return {
        filepath: v.filepath,
        endpoint: v.endpoint,
        method: v.method,
        name: v.name,
        description: v.description
      };
    });
  }

  public getSpecByMethodAndEndpoint(method: string, endpoint: string) {
    return this.specList.find(v => v.method === method && v.endpoint === endpoint);
  }

  public getSpecByFilepath(filepath: string) {
    return this.specList.find(v => v.filepath === filepath);
  }
}

