const Elm = require("./Main.elm");
require("./main.scss");

document.addEventListener("DOMContentLoaded", () => {
  const mainDiv = document.getElementById("main");
  Elm.Main.embed(mainDiv);
});
