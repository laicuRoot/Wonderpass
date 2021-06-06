// import mapboxgl from 'mapbox-gl';
// import 'mapbox-gl/dist/mapbox-gl.css';

// const customiseMarkers = () => {
// 	const element = document.createElement('div');
// 	element.className = 'marker';
// 	element.style.backgroundImage = `url('${marker.image_url}')`;
// 	element.style.backgroundSize = 'contain';
// 	element.style.width = '25px';
// 	element.style.height = '25px';
// 	return element;
// }

// const addMarkers = (map, markers) =>{
// 	markers.forEach((marker) => {
// 		  const popup = new mapboxgl.Popup().setHTML(marker.stamp_window);
// 			const pic = customiseMarkers;
// 			new mapboxgl.Marker(pic)
// 				.setLngLat([ marker.lng, marker.lat ])
// 				.setPopup(popup)
// 				.addTo(map);
// 	});
// }

// const fitMapToMarkers = (map, markers) => {
//   const bounds = new mapboxgl.LngLatBounds();
//   markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
//   map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
// };

// const initMapbox = () => {
//   let mapElement = document.querySelector('.map');
//   let cont = ((document.getElementById("user-map"))? "user-map" : "itinerary-map");
//   if (mapElement) { // only build a map if there's a div#map to inject into
//     mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
//     if (mapElement.dataset.markers) {
//       const markers = JSON.parse(mapElement.dataset.markers);
//       const map = new mapboxgl.Map({
//         container: cont,
//         style: 'mapbox://styles/rubixthecubix/ckpa6hfqu6ejy18oj9bz9d98a'
//       });
//       console.log(map);
//       addMarkers(map, markers);
//       fitMapToMarkers(map, markers);
//     }
//   }
// };

// export { initMapbox };
