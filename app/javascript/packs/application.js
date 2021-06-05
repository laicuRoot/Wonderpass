// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("page-flip")
var $ = require( "jquery" )
require("slick-carousel")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";
import "slick-carousel/slick/slick.scss"
import "slick-carousel/slick/slick-theme.scss"

import 'controllers'
// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';
import { initMapbox } from '../plugins/init_mapbox';
import { toggleMenu } from '../plugins/init_menu';
import { hideProfile } from '../plugins/init_hide_profile';
import { addSelectedClass } from '../plugins/add_selected';
import { initPageFlip } from '../plugins/init_turning-pages';
<<<<<<< HEAD
import { init_slick } from '../plugins/slick_carousel';
=======
import { initAutocomplete } from '../plugins/init_autocomplete';
import { addActiveItinerary } from '../plugins/add_active_itinerary'
>>>>>>> 6832ef5202ffb286fdd071e84acc445c79a4ef21

document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  // addSelectedClass();
  // initSelect2();
  initMapbox();
  toggleMenu();
  hideProfile();
<<<<<<< HEAD
  // initPageFlip();
  init_slick();
=======
  if (document.getElementById("book")){
    initPageFlip();
  }
  initAutocomplete();
  addActiveItinerary();
>>>>>>> 6832ef5202ffb286fdd071e84acc445c79a4ef21
});
