import SpecList from "../models/specList";
import GitWrapper from "../models/gitWrapper";
import {Request, Response} from "express";

function doSpecList(specList: SpecList, req: Request, res: Response) {
  specList.load().then(() => {
    const list = specList.list();
    res.json(list);
  });
}

export default function(specList: SpecList, gitUrl: string, gitBranch: string, req: Request, res: Response) {
  if (gitUrl) {
    new GitWrapper("work", gitUrl, gitBranch).sync((err) => {
      if (err) {
        res.status(500);
        res.send(err);
      } else {
        doSpecList(specList, req, res);
      }
    });
  } else {
    doSpecList(specList, req, res);
  }
}
