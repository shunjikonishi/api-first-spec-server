import SpecList from "../models/specList";
import {Request, Response} from "express";

export default function(specList: SpecList, req: Request, res: Response) {
  let sortField = req.query["sort.field"];
  const sortDirection = req.query["sort.direction"];

  const list = specList.list().sort((a, b) => {
    const desc = sortDirection === "desc";
    let av, bv: string;
    switch (sortField) {
      case "name":
        av = a.name;
        bv = b.name;
        break;
      case "method":
        av = a.method + a.name;
        bv = b.method + b.name;
        break;
      case "endpoint":
        av = a.endpoint;
        bv = b.endpoint;
        break;
      default:
        av = a.filepath || a.name;
        bv = b.filepath || a.name;
        break;
    }
    let result = av.localeCompare(bv);
    if (desc) {
      result = 0 - result;
    }
    return result;
  });
  res.json(list);
}
