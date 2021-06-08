const addSelectedClass = () => {
  const itineraryItems = document.querySelectorAll(".itinerary-button");
  console.log(itineraryItems);
  if (itineraryItems){
    itineraryItems.forEach( element =>{
      element.addEventListener("click", (event) =>{
        if (event.currentTarget.classList.contains("selected")){
          event.currentTarget.classList.remove("selected");
        } else{
          event.currentTarget.classList.add("selected");
        }
      });
    });
  }
}

export { addSelectedClass };