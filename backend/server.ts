import express  from "express";
import SpecList from "./models/specList";

import specApi from "./routes/specApi";

const PORT = process.env.PORT || 7000;
const app = express();

process.env.API_FIRST_SPEC_SKIP_TEST = "true";

const specDir = process.env.SPEC_DIR || "./specs";
const gitUrl = process.env.GIT_URL || null;
const gitBranch = process.env.GIT_BRANCH || "master";

const specList = new SpecList(specDir);

app.set("views", "backend/views");
app.set("view engine", "ejs");
app.use("/assets", express.static("assets"));

app.use("/api", specApi(specList, gitUrl, gitBranch));

app.get("/*", (req, res) => {
  res.render("index", {
    title: "API-First-Spec Documents"
  });
});


app.listen(PORT, () => console.log(`Example app listening on port ${PORT}!`));