import express  from "express";
import SpecList from "../models/specList";

import GetSpecList from "../controllers/getSpecList";
import GetSpecDetail from "../controllers/getSpecDetail";
import ResetSpecList from "../controllers/resetSpecList";

export default function specAPI(specList: SpecList, gitUrl: string | null, gitBranch: string): express.Router {
  const router = express.Router();

  router.get("/specs", GetSpecList.bind(GetSpecList, specList));
  router.get("/specs/*", GetSpecDetail.bind(GetSpecDetail, specList));
  router.post("/reset", ResetSpecList.bind(ResetSpecList, specList, gitUrl, gitBranch));

  return router;
}
