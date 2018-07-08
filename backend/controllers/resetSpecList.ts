import SpecList from "../models/specList";
import {Request, Response} from "express";

export default function(specList: SpecList, req: Request, res: Response) {
  specList.load().then(() => {
    const list = specList.list();
    res.json(list);
  });
}
