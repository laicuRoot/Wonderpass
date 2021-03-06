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
require("jquery")
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
import 'controllers';
import "dropzone/dist/min/dropzone.min.css";
import "dropzone/dist/min/basic.min.css";
// import "stylesheets/application";
// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';
import { initMapbox } from '../plugins/init_mapbox';
import { addToggleMenus } from '../plugins/init_menu';
import { hideProfile } from '../plugins/init_hide_profile';
import { toggleHidden } from '../plugins/add_selected';
import { initPageFlip } from '../plugins/init_turning-pages';
import { generateRoutes } from '../plugins/routes';
import { initAutocomplete } from '../plugins/init_autocomplete';
import { addActiveItinerary } from '../plugins/add_active_itinerary';
import { addOtherOption } from '../plugins/add_other_option';
import { initSlick } from '../plugins/slick_carousel';

document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  toggleHidden();
  initMapbox();
  addToggleMenus();
  hideProfile();
  if (document.getElementById("book")){
    initPageFlip();
  }
  addActiveItinerary();
  addOtherOption();
  initSlick();
  initAutocomplete();
  generateRoutes();
});
