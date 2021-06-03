// import { Controller } from "stimulus";

// export default class extends Controller {
//   static targets = [ 'itineraryItem' ];
//   static targets = [ 'itinerary' ];

//   connect() {
//     console.log(this.itineraryItemTargets);
//   }

//   update(event){
//     // When the stamp is selected again, the active class will be removed
//     // the itinerary item will be deleted using the retrieved stamp and itinerary id
//     // A destroy request will be made to delete the item
//     const stamp = event.currentTarget;
//     const stampId = event.currentTarget.data.get('id');
//     const itinId = this.itineraryTarget.data.get('id');
//     if (stamp.querySelector(".selected")){
//         stamp.classList.remove("selected");
//         fetch(`/itinerary/${itinId}/itinerary_item/${}`, {
//             method: 'DELETE',
//             })
//             .then(response => response.json()) // or res.json()
//             .then((data) => {
              
//             });
//     } else {

//         // When a stamp is selected, a 'selected' class will be added
//         // The stamp ID will be retrieved
//         // the itinerary ID will be retrieved
//         // A post request will be made to generate the item
//         stamp.classList.add("selected");
//         fetchWithToken(`/itinerary/${itinId}/itinerary_item/create`, {
//             method: "POST",
//             headers: {
//               "Accept": "application/json",
//               "Content-Type": "application/json"
//             },
//             body: JSON.stringify({ itinerary_item: { stamp_id: stampId, itinerary_id: itinId }})
//           })
//             .then(response => response.json())
//             .then((data) => {
              
//             });
//     }  
//   }
// }
