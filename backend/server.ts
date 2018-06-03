import express  from "express";

const PORT = process.env.PORT || 7000;
const app = express();

app.set("views", "backend/views");
app.set("view engine", "ejs");
app.use("/assets", express.static("assets"));

app.get("/*", (req, res) => {
  res.render("index", {
    title: "test"
  });
});


app.listen(PORT, () => console.log(`Example app listening on port ${PORT}!`));