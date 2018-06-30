import SpecList from "../models/specList";
import SpecSerializer from "../models/specSerializer";
import {Request, Response} from "express";

const serializer = new SpecSerializer();

export default function(specList: SpecList, req: Request, res: Response) {
  const spec = specList.getSpecByFilepath(req.path);
  if (!spec) {
    res.sendStatus(404);
    return;
  }
  res.json(serializer.serialize(spec));
}
