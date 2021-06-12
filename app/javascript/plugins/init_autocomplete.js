import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.getElementById('itinerary_destination');
  if (addressInput) {
    places({ container: addressInput, countries: ["GB", "GI"] });
  }
};

export { initAutocomplete };
