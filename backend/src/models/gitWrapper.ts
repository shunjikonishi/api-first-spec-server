import path from "path";
import fs from "fs";
import simpleGit from "simple-git";

export default class GitWrapper {
  private workDir: string;

  constructor(workDir: string, private url: string, private branch: string) {
    this.workDir = path.normalize(workDir);
    if (!path.isAbsolute(this.workDir)) {
      this.workDir = process.cwd() + "/" + this.workDir;
    }

  }

  public sync(callback: (err: any) => void) {
    const gitDir = this.workDir + "/git";
    if (fs.existsSync(gitDir) && fs.statSync(gitDir).isDirectory) {
      this.doPull(gitDir, callback);
    } else {
      this.doClone(gitDir, callback);
    }
  }

  private doPull(gitDir: string, callback: (err: any) => void) {
    const git = simpleGit(gitDir).pull(callback);
  }

  private doClone(gitDir: string, callback: (err: any) => void) {
    const git = simpleGit().clone(this.url, gitDir, (err: any) => {
      if (err) {
        callback(err);
      } else {
        git.checkout(this.branch, callback);
      }
    });
  }
}