import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

const addToggle = () => {
  let toggles = document.querySelectorAll(".route-header");
  toggles.forEach(element =>{
    element.addEventListener("click", event => {
      event.currentTarget.nextSibling.classList.toggle("hidden-route");
    })
  })
}

const createDirections = (data) =>{
  document.getElementById("route-distance").innerHTML = `<strong>Distance:</strong> ${Math.round(data.distance * 0.001)}km`;
  document.getElementById("route-duration").innerHTML = `<strong>Time expected:</strong> ${new Date(data.duration * 1000).toISOString().substr(11, 8)}`;
  console.log("time", data.duration)
  let instructionNumber = 1
  let routeInfo = document.getElementById("route-instructions");
  routeInfo.innerHTML = "";
  console.log(data.legs);
  let journeyCount = 0;
  data.legs.forEach((leg) => {
    journeyCount += 1;
    routeInfo.insertAdjacentHTML("beforeend", `<div class = 'route-header' style: "display:flex;"><p style="font-weight:bold; width:90%; display:inline-block;">Leg ${journeyCount} - from ${leg.summary.replace(',', ' to ')}</p>
                                                <span style="font-size:20px;"><i class="fas fa-caret-down"></i></span>
                                              </div>`);
    routeInfo.insertAdjacentHTML("beforeend", "<div class = 'route-toggle hidden-route'></div>");
    leg.steps.forEach((step) => {
      routeInfo.lastChild.insertAdjacentHTML("beforeend", `<div class = 'route-details'>${instructionNumber} ${step.maneuver.instruction}</div>`)
      instructionNumber += 1
    })
  });
  addToggle();
}

const getRoute = (endCoords, transportProfile, map, markers) => {
  // make a directions request using cycling profile
  // an arbitrary start will always be the same
  // only the end or destination will change
  var url = "https://api.mapbox.com/directions/v5/mapbox/"

  url += transportProfile + "/"

  if(markers.length > 0) {
    markers.forEach(marker => { url += marker.lng + "," + marker.lat + ";" });
    url = url.slice(0,-1)
    url += '?steps=true&geometries=geojson&access_token=' + mapboxgl.accessToken
  };
  console.log(markers)

  console.log(url)

  // var url = "https://api.mapbox.com/directions/v5/mapbox/cycling/-0.0747088,51.5328915;-0.0775,51.5235693?geometries=geojson&access_token="

  // make an XHR request https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest
  
   var req = new XMLHttpRequest();
  req.open('GET', url, true);
  req.onload = function() {
    var json = JSON.parse(req.response);
    console.log(json)
    var data = json.routes[0];
    console.log(data)
    var route = data.geometry.coordinates;
    console.log(route)
    var geojson = {
      type: 'Feature',
      properties: {},
      geometry: {
        type: 'LineString',
        coordinates: route
      }
    };

  createDirections(data);
      // if the route already exists on the map, reset it using setData
  if (map.getSource('route')) {
    map.getSource('route').setData(geojson);
  } else { // otherwise, make a new request
    map.addLayer({
      id: 'route',
      type: 'line',
      source: {
        type: 'geojson',
        data: {
          type: 'Feature',
          properties: {},
          geometry: {
            type: 'LineString',
            coordinates: geojson
          }
        }
      },
      layout: {
        'line-join': 'round',
        'line-cap': 'round'
      },
      paint: {
        'line-color': '#FFDE55',
        'line-width': 5,
        'line-opacity': 0.75
      }
    });
  // if (map.getSource('routearrows')) {
  //   map.getSource('routearrows').setData(route);
  // } else {
  //   map.addLayer({
  //     id: 'routearrows',
  //     type: 'symbol',
  //     source: {
  //           type: 'geojson',
  //           data: {
  //             type: 'Feature',
  //             properties: {},
  //             geometry: {
  //               type: 'LineString',
  //               coordinates: route
  //             }
  //           }
  //         },
  //     layout: {
  //       'symbol-placement': 'line',
  //       'text-field': '▶',
  //       'text-size': [
  //         "interpolate",
  //         ["linear"],
  //         ["zoom"],
  //         12, 24,
  //         22, 120,
  //         40, 100
  //       ],
  //       'symbol-spacing': [
  //         "interpolate",
  //         ["linear"],
  //         ["zoom"],
  //         12, 30,
  //         22, 160,
  //         40, 200
  //       ],
  //       'text-keep-upright': false
  //     },
  //     paint: {
  //       'text-color': '#FFDE55',
  //       'text-halo-color': 'hsl(55, 11%, 96%)',
  //       'text-halo-width': 3
  //     }
  //   }, 'waterway-label');

  //     }
    };
  };
      
  req.send();
}

const mapRoute = (map, markers, transportProfile, lastItemIndex, start) => {
  console.log("map", map);
  // map.on('load', function() {
    console.log(map);
    // make an initial directions request that
    // starts and ends at the same location
    getRoute(start, transportProfile, map, markers);
    // Add starting point to the map
    if (map.getLayer('point')) {
        map.getSource('point').setData(start);
      } else {
        map.addLayer({
          id: 'point',
          type: 'circle',
          source: {
            type: 'geojson',
            data: {
              type: 'FeatureCollection',
              features: [{
                type: 'Feature',
                properties: {},
                geometry: {
                  type: 'Point',
                  coordinates: start
                }
              }
              ]
            }
          },
          paint: {
            'circle-radius': 10,
            'circle-color': '#3887be'
          }
        });
      }
      // this is where the code from the next step will go
      var end = {
        type: 'FeatureCollection',
        features: [{
          type: 'Feature',
          properties: {},
          geometry: {
            type: 'Point',
            coordinates: [markers[lastItemIndex].lng, markers[lastItemIndex].lat]
          }
        }
        ]
      };
      if (map.getLayer('end')) {
        map.getSource('end').setData(end);
      } else {
        map.addLayer({
          id: 'end',
          type: 'circle',
          source: {
            type: 'geojson',
            data: {
              type: 'FeatureCollection',
              features: [{
                type: 'Feature',
                properties: {},
                geometry: {
                  type: 'Point',
                  coordinates: [markers[lastItemIndex].lng, markers[lastItemIndex].lat]
                }
              }]
            }
          },
          paint: {
            'circle-radius': 10,
            'circle-color': '#f30'
          }
        });
      }
    getRoute(end, transportProfile, map, markers);
  // });
}


const createMap = (start) => {
  var map = new mapboxgl.Map({
    container: 'map2',
    style: 'mapbox://styles/mapbox/light-v10',
    center: start, // starting position
    zoom: 12
  });
  return map
}

const generateMarkers = (map, markers) => {
  markers.forEach((marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.stampWindow);
    new mapboxgl.Marker()
      .setLngLat([marker.lng, marker.lat])
      .setPopup(popup)
      .addTo(map);
  });
  
}

const changeRoute = (map, markers, lastItemIndex, start) => {
  const itineraryButtons = document.querySelectorAll(".transport-button");
  if (itineraryButtons){
    itineraryButtons.forEach( element =>{
      element.addEventListener("click", (event) =>{
        itineraryButtons.forEach( element =>{
          element.classList.remove("round-yellow-button-route");
          element.classList.add("round-grey-button-route");
        })
        event.currentTarget.classList.remove("round-grey-button-route");
        event.currentTarget.classList.add("round-yellow-button-route");
        let transportProfile = event.currentTarget.id;
        console.log(transportProfile);
        mapRoute(map, markers, transportProfile, lastItemIndex, start);
      });
    });
  } 
}

const generateRoutes = () => {
  if (document.getElementById('map2')){
    const mapElement = document.getElementById('map2');
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const markers = JSON.parse(mapElement.dataset.markers);
    let transportProfile = "walking";
    const start = [markers[0].lng, markers[0].lat];
    const lastItemIndex = markers.length - 1
    const map = createMap(start);
    const canvas = map.getCanvasContainer();
    generateMarkers(map, markers);
    map.on('load', function() {
      mapRoute(map, markers, transportProfile, lastItemIndex, start);
    });
    changeRoute(map, markers,lastItemIndex, start);
  }
}

export { generateRoutes };
