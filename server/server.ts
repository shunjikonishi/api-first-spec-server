import express  from "express";

const PORT = process.env.PORT || 3000;
const app = express();

app.set("views", "server/views");
app.set("view engine", "ejs");

app.get("/*", (req, res) => {
  res.render("index", {
    title: "test"
  });
});


app.listen(PORT, () => console.log(`Example app listening on port ${PORT}!`));