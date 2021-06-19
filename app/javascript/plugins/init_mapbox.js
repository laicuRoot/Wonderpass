import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';
import 'jquery';

const customiseMarkers = () => {
	const element = document.createElement('div');
	element.className = 'marker';
	element.style.backgroundImage = `url('${marker.imageUrl}')`;
	element.style.backgroundSize = 'contain';
	element.style.width = '25px';
	element.style.height = '25px';
	return element;
}

const addMarkers = (map, markers) =>{
	markers.forEach((marker) => {
		  const popup = new mapboxgl.Popup().setHTML(marker.stampWindow);
			const pic = customiseMarkers;
      let completedColor = "#fcf4d4";
      if (marker.stampStatus){
        completedColor = "#FFDE55";
      }
			new mapboxgl.Marker({pic, color: completedColor})
				.setLngLat([ marker.lng, marker.lat ])
				.setPopup(popup)
				.addTo(map);
	});
}

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
};

const getMapElements = () => {
  if (document.getElementById("user-map")){
    return "user-map";
  } else if (document.getElementById("itinerary-map")){
    return "itinerary-map";
  } else {
    return "map2";
  }
};

const toggleMarkers = (map, mapElement) =>{
  const toggle = document.querySelector(".toggle-all");
  if (toggle) {
    const activeMarkers = JSON.parse(mapElement.dataset.markers);
    const allMarkers = JSON.parse(mapElement.dataset.allMarkers);
    toggle.addEventListener("click", event =>{
      let target = event.currentTarget;
      console.log(target.innerHTML);
      if (target.innerHTML == '<i class="fas fa-eye"></i> See all stamps'){
        target.innerHTML = '<i class="fas fa-eye"></i> View active itinerary';
        $('.mapboxgl-marker').remove();
        addMarkers(map, allMarkers);
        fitMapToMarkers(map, allMarkers);
      } else if (target.innerHTML == '<i class="fas fa-eye"></i> View active itinerary'){
        target.innerHTML = '<i class="fas fa-eye"></i> See all stamps';
        $('.mapboxgl-marker').remove();
        addMarkers(map, activeMarkers);
        fitMapToMarkers(map, activeMarkers);
      }
    });
  }
}

const myLocation = (map) => {
  // Add geolocate control to the map.
  map.addControl(new mapboxgl.GeolocateControl(
	  { positionOptions: { enableHighAccuracy: true },
	   trackUserLocation: true,
	   fitBoundsOptions: {maxZoom: 7}
	  })
	);
}

// myLocation.on('myLocation', (e) =>{
//   console.log('vibes');
// })

const initMapbox = () => {
  let mapElement = document.querySelector('.map');
  let cont = getMapElements();
  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    if (mapElement.dataset.markers) {
      const markers = JSON.parse(mapElement.dataset.markers);
      const map = new mapboxgl.Map({
        container: cont,
        style: 'mapbox://styles/rubixthecubix/ckpa6hfqu6ejy18oj9bz9d98a',
      });
      console.log(map);
      addMarkers(map, markers);
      fitMapToMarkers(map, markers);
      if (cont == "user-map"){
        toggleMarkers(map, mapElement);
      }
      myLocation(map);
    }
  }
};



export { initMapbox };
