
const addStyle = (button) =>{
  button.style.pointerEvents = 'auto';
  button.style.opacity = 1;
}

const removeStyle = (button) => {
  button.style.pointerEvents = 'none';
  button.style.opacity = 0.5;
}

const toggleMenu = (allButtons) => {
  const currentMenu = document.querySelector(".user-menu-popup")
  if (currentMenu) {
    const currentMenuButton = document.getElementById("user-menu-button");
    const currentRemoveButton = document.getElementById("user-menu-exit");
    currentMenuButton.addEventListener("click", () => {
      currentMenu.style.display = "inline-block";
      allButtons.forEach(element=>{ removeStyle(element)});
    })
    currentRemoveButton.addEventListener("click", () =>{
      currentMenu.style.display = "none";
      allButtons.forEach(element=>{ addStyle(element)});
    })
  }
}

const toggleFriendMenu = (allButtons) => {
  const currentMenu = document.querySelector(".friends-menu-popup")
  if (currentMenu) {
    const currentMenuButton = document.getElementById("user-menu-friends");
    const currentRemoveButton = document.getElementById("friends-menu-exit");
    currentMenuButton.addEventListener("click", () => {
      currentMenu.style.display = "inline-block";
      allButtons.forEach(element=>{ removeStyle(element)});
    })
    currentRemoveButton.addEventListener("click", () =>{
      currentMenu.style.display = "none";
      allButtons.forEach(element=>{ addStyle(element)});
    })
  }
}

const toggleLeaderBoardMenu = (allButtons) => {
  const currentMenu = document.querySelector(".user-menu-popup-leaderboard")
  if (currentMenu) {
    const currentMenuButton = document.getElementById("user-menu-button-leaderboard");
    const currentRemoveButton = document.getElementById("user-menu-exit-leaderboard");
    currentMenuButton.addEventListener("click", () => {
      currentMenu.style.display = "inline-block";
      allButtons.forEach(element=>{ removeStyle(element)});
    })
    currentRemoveButton.addEventListener("click", () =>{
      currentMenu.style.display = "none";
      allButtons.forEach(element=>{ addStyle(element)});
    })
  }
}

const addToggleMenus = () => {
  const allButtons = document.querySelectorAll(".menu");
  toggleMenu(allButtons);
  toggleFriendMenu(allButtons);
  toggleLeaderBoardMenu(allButtons);
}

export { addToggleMenus }
