const toggleHidden = () =>{
  const button = document.querySelector(".direction-arrow");
  console.log(button);
  if (button){
    button.addEventListener("click", event =>{
      console.log(button);
      const directionBox = document.querySelector('.direction-box');
      directionBox.classList.toggle("hidden-direction");
      const routeBox = document.querySelector('.route-box');
      routeBox.classList.toggle("hidden-route-box");
    });
  }
}

// const addSelectedClass = () => {
//   const itineraryButtons = document.querySelectorAll(".transport-button");
//   if (itineraryButtons){
//     itineraryButtons.forEach( element =>{
//       element.addEventListener("click", (event) =>{
//         itineraryButtons.forEach( element =>{
//           element.classList.remove("round-yellow-button-route")
//           element.classList.add("round-grey-button-route")
//         })
//         event.currentTarget.classList.remove("round-grey-button-route")
//         event.currentTarget.classList.add("round-yellow-button-route");
//       });
//     });
//   }
// }

export { toggleHidden };