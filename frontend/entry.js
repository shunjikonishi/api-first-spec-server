const Elm = require("./main.elm");


document.addEventListener("DOMContentLoaded", () => {
  const mainDiv = document.getElementById("main");
  console.log(Elm);
  console.log(mainDiv);
  Elm.Main.embed(mainDiv);
});
