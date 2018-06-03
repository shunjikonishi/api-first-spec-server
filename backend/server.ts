import express  from "express";
import SpecList from "./models/specList";

const PORT = process.env.PORT || 7000;
const app = express();

const specDir = process.env.SPEC_DIR || "./spec";
const specList = new SpecList(specDir);

app.set("views", "backend/views");
app.set("view engine", "ejs");
app.use("/assets", express.static("assets"));

app.get("/*", (req, res) => {
  res.render("index", {
    title: "test"
  });
});

console.log("test", specList);

app.listen(PORT, () => console.log(`Example app listening on port ${PORT}!`));