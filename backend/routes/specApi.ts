import express  from "express";
import SpecList from "../models/specList";

import GetSpecList from "../controllers/getSpecList";
import GetSpecDetail from "../controllers/getSpecDetail";

export default function specAPI(specList: SpecList): express.Router {
  const router = express.Router();

  router.get("/", GetSpecList.bind(GetSpecList, specList));
  router.get("/*", GetSpecDetail.bind(GetSpecDetail, specList));

  return router;
}
