
const toggleMenu = () =>{
    const menuButton = document.getElementById("user-menu-button");
    const removeButton = document.getElementById("user-menu-exit");
    const menu = document.querySelector(".user-menu-popup")
    menuButton.addEventListener("click", () => {
      menu.style.display = "inline-block";
    })
    removeButton.addEventListener("click", () =>{
      menu.style.display = "none";
    })
}

export {toggleMenu}