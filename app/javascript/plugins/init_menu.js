
const toggleMenu = () =>{
    const menuButton = document.getElementById("user-menu-button");
    const removeButton = document.getElementById("user-menu-exit");
    const menu = document.querySelector(".user-menu-popup")
    const friendButton = document.getElementById("user-menu-friends");
    if(menu){
      menuButton.addEventListener("click", () => {
        menu.style.display = "inline-block";
        friendButton.style.display = "none";
    })
      removeButton.addEventListener("click", () =>{
        menu.style.display = "none";
        friendButton.style.display = "";
      })
    }
}

const toggleFriendMenu = () =>{
    const mainmenuButton = document.getElementById("user-menu-button");
    const menuButton = document.getElementById("user-menu-friends");
    const removeButton = document.getElementById("friends-menu-exit");
    const menu = document.querySelector(".friends-menu-popup")
    if(menu){
      menuButton.addEventListener("click", () => {
      menu.style.display = "inline-block";
      mainmenuButton.style.display = "none";
    })
      removeButton.addEventListener("click", () =>{
        menu.style.display = "none";
        mainmenuButton.style.display = "";
      })
    }
}

export {toggleMenu, toggleFriendMenu}
