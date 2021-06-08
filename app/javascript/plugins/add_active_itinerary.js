const active = (e) => {
  e.preventDefault();
  const active = document.querySelector('.active-itinerary');
  if(active){
    active.classList.remove('active-itinerary');
    active.innerText = 'Set Active'
  }
  event.currentTarget.classList.add('active-itinerary')
  event.currentTarget.innerText = 'Active'
}

const addActiveItinerary = () => {

  const itinerariesBtns = document.querySelectorAll('#itinerary-btn');
  if(itinerariesBtns){
    itinerariesBtns.forEach((itinerary)=>{
      itinerary.addEventListener('click', active)
    });
  }
}



export {addActiveItinerary}
