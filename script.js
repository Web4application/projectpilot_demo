// script.js
document.addEventListener("DOMContentLoaded", () => {
  const consoleEl = document.querySelector(".console");
  const lines = consoleEl.innerHTML.split("\n");

  consoleEl.innerHTML = "";
  let i = 0;

  const typeNext = () => {
    if (i < lines.length) {
      consoleEl.innerHTML += lines[i] + "<br>";
      i++;
      setTimeout(typeNext, 500);
    }
  };
  
  typeNext();
});
