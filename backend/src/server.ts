import express  from "express";
import SpecList from "./models/specList";

import specApi from "./routes/specApi";

const PORT = process.env.PORT || 7000;

const JS_PATH  = process.env.JS_PATH || "/assets/js/app.js";
const CSS_PATH = process.env.CSS_PATH || "/assets/css/app.css";

const app = express();

process.env.API_FIRST_SPEC_SKIP_TEST = "true";

const specDir = process.env.SPEC_DIR || "./specs";
const gitUrl = process.env.GIT_URL || null;
const gitBranch = process.env.GIT_BRANCH || "master";

const specList = new SpecList(specDir);

app.set("views", "src/views");
app.set("view engine", "ejs");
app.use("/assets", express.static("assets"));

app.use("/api", specApi(specList, gitUrl, gitBranch));

app.get("/assets/css/dummy.css", (req, res) => {
  res.set("Content-Type", "text/css");
  res.send("/* dummy */");
});

app.get("/*", (req, res) => {
  res.render("index", {
    title: "API-First-Spec Documents",
    jsPath: JS_PATH,
    cssPath: CSS_PATH
  });
});


app.listen(PORT, () => console.log(`Example app listening on port ${PORT}!`));