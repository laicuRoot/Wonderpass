const hideProfile = () => {
   const button = document.getElementById("hide-profile");
   const profile = document.querySelector(".profile-box");
  if(button){
    button.addEventListener("click", event =>{
     if (button.classList.contains("view-profile")){
       button.classList.remove("view-profile");
       button.innerHTML = '<i class="fas fa-arrow-right"></i>';
       button.classList.add("hide-profile");
       profile.classList.add("hidden");
     } else{
       button.classList.remove("hide-profile");
       button.classList.add("view-profile");
       button.innerHTML = '<i class="fas fa-arrow-left"></i>';
       profile.classList.remove("hidden");
     }
   })
  }
}
export { hideProfile };
