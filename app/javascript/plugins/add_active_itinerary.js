const active = (e) => {
  e.preventDefault();
  const active = document.querySelector('.active-itinerary');
  if(active){
    active.classList.remove('active-itinerary');
    active.innerText = 'Set Active'
  }
  e.currentTarget.classList.add('active-itinerary')
  e.currentTarget.innerText = 'Active'
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
