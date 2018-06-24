import SpecList from "../models/specList";
import SpecSerializer from "../models/specSerializer";
import {Request, Response} from "express";

const serializer = new SpecSerializer();

export default function(specList: SpecList, req: Request, res: Response) {
  const method = req.query.method;
  const endpoint = req.query.endpoint;
  if (!method || !endpoint) {
    res.sendStatus(400);
    return;
  }
  const spec = specList.get(method, endpoint);
  if (!spec) {
    res.sendStatus(404);
    return;
  }
  res.json(serializer.serialize(spec));
}
