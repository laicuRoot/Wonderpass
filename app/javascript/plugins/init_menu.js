
const toggleMenu = () => {
  const currentMenu = document.querySelector(".user-menu-popup")
  const currentMenuButton = document.getElementById("user-menu-button");
  const currentRemoveButton = document.getElementById("user-menu-exit");

  const friendButton = document.getElementById("user-menu-friends");
  const leaderboardButton = document.getElementById("user-menu-button-leaderboard");

  if (currentMenu) {
    currentMenuButton.addEventListener("click", () => {
      currentMenu.style.display = "inline-block";

      friendButton.style.pointerEvents = 'none';
      leaderboardButton.style.pointerEvents = 'none';

      friendButton.style.opacity = 0.5;
      leaderboardButton.style.opacity = 0.5;

      friendButton.style.display = "none";
      leaderboardButton.style.display = "none";
    })
    currentRemoveButton.addEventListener("click", () =>{
      currentMenu.style.display = "none";
      friendButton.style.display = "";
      leaderboardButton.style.display = "";

      friendButton.style.pointerEvents = 'auto';
      leaderboardButton.style.pointerEvents = 'auto';

      friendButton.style.opacity = 1;
      leaderboardButton.style.opacity = 1;

      friendButton.style.display = "inline-block";
      leaderboardButton.style.display = "inline-block";
    })
  }
}

const toggleFriendMenu = () => {
  const currentMenu = document.querySelector(".friends-menu-popup")
  const currentMenuButton = document.getElementById("user-menu-friends");
  const currentRemoveButton = document.getElementById("friends-menu-exit");

  const userButton = document.getElementById("user-menu-button");
  const leaderboardButton = document.getElementById("user-menu-button-leaderboard");

  if (currentMenu) {
    currentMenuButton.addEventListener("click", () => {
      currentMenu.style.display = "inline-block";

      userButton.style.pointerEvents = 'none';
      leaderboardButton.style.pointerEvents = 'none';

      userButton.style.opacity = 0.5;
      leaderboardButton.style.opacity = 0.5;

      leaderboardButton.style.display = "none";
    })
    currentRemoveButton.addEventListener("click", () =>{
      currentMenu.style.display = "none";
      userButton.style.display = "";
      leaderboardButton.style.display = "";

      userButton.style.pointerEvents = 'auto';
      leaderboardButton.style.pointerEvents = 'auto';

      userButton.style.opacity = 1;
      leaderboardButton.style.opacity = 1;

      leaderboardButton.style.display = "inline-block";
    })
  }
}

const toggleLeaderBoardMenu = () => {
  const currentMenu = document.querySelector(".user-menu-popup-leaderboard")
  const currentMenuButton = document.getElementById("user-menu-button-leaderboard");
  const currentRemoveButton = document.getElementById("user-menu-exit-leaderboard");

  const userButton = document.getElementById("user-menu-button");
  const friendButton = document.getElementById("user-menu-friends");

  if (currentMenu) {
    currentMenuButton.addEventListener("click", () => {
      currentMenu.style.display = "inline-block";

      userButton.style.pointerEvents = 'none';
      friendButton.style.pointerEvents = 'none';

      userButton.style.opacity = 0.5;
      friendButton.style.opacity = 0.5;
    })
    currentRemoveButton.addEventListener("click", () =>{
      currentMenu.style.display = "none";
      userButton.style.display = "";
      friendButton.style.display = "";

      userButton.style.pointerEvents = 'auto';
      friendButton.style.pointerEvents = 'auto';

      userButton.style.opacity = 1;
      friendButton.style.opacity = 1;
    })
  }
}

export {toggleMenu, toggleFriendMenu, toggleLeaderBoardMenu}
