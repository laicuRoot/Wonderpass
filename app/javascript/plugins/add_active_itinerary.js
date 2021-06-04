const addActiveItinerary = () => {
  const itineraries = document.querySelectorAll('#itinerary-btn');
  if(itineraries){
    itineraries.forEach((itinerary) => {
      itinerary.addEventListener('click', (event) => {
        if(event.currentTarget.classList.contains('active-itinerary')){
          event.currentTarget.classList.remove('active-itinerary');
          event.currentTarget.innerText = 'Set Active'
        } else {
          event.currentTarget.classList.add('active-itinerary');
          event.currentTarget.innerText = 'Active'
        }
      })
    })
  }
}

export {addActiveItinerary}
