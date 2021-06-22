import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.getElementById('itinerary_destination');
  if (addressInput) {
    places({ container: addressInput });
  }

  const locationInput = document.getElementById('location_location_name');
  if (locationInput) {
    places({ container: locationInput });
  }
};

export { initAutocomplete };
