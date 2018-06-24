import express  from "express";
import SpecList from "./models/specList";

import GetSpecList from "./controllers/getSpecList";
import GetSpecDetail from "./controllers/getSpecDetail";

const PORT = process.env.PORT || 7000;
const app = express();

process.env.API_FIRST_SPEC_SKIP_TEST = "true";

const specDir = process.env.SPEC_DIR || "./spec";
const specList = new SpecList(specDir);

app.set("views", "backend/views");
app.set("view engine", "ejs");
app.use("/assets", express.static("assets"));

app.get("/api/specs/list", GetSpecList.bind(GetSpecList, specList));
app.get("/api/specs/detail", GetSpecDetail.bind(GetSpecDetail, specList));

app.get("/*", (req, res) => {
  res.render("index", {
    title: "API-First-Spec Documents"
  });
});


app.listen(PORT, () => console.log(`Example app listening on port ${PORT}!`));