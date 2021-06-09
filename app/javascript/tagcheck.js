if (location.pathname.match("items/tagcheck")){
  document.addEventListener("DOMContentLoaded", () => {
    const inputElement = document.getElementById("name");
    inputElement.addEventListener("keyup", () => {
      const keyword = document.getElementById("name").value;
      const XHR = new XMLHttpRequest();
      XHR.open("GET", `search/?keyword=${keyword}`, true);
      XHR.responseType = "json";
      XHR.send();
      XHR.onload = () => {
        const searchResult = document.getElementById("search-result");
        searchResult.innerHTML = "";
        if (XHR.response) {
          const tagName = XHR.response.keyword;
          tagName.forEach((tag) => {
            const childElement = document.createElement("div");
            childElement.setAttribute("class", "child");
            childElement.setAttribute("id", tag.id);
            childElement.innerHTML = tag.name;
            searchResult.appendChild(childElement);
            const clickElement = document.getElementById(tag.id);
            clickElement.addEventListener("click", () => {
              document.getElementById("name").value = clickElement.textContent;
              clickElement.remove();
            });
          });
        };
      };
    });
  });
}