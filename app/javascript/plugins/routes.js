import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

mapboxgl.accessToken = "pk.eyJ1IjoicnViaXh0aGVjdWJpeCIsImEiOiJja213YmVid3EwZGZ2MnZudnI1OGN6Zm9mIn0.o9_KQSxzMvHX53JtF-hX5A"

const mapElement = document.getElementById('map2');

const markers = JSON.parse(mapElement.dataset.markers);

var start = [markers[0].lng, markers[0].lat];
// var end = [markers[1].lng, markers[1].lat];

var transport_profile = "walking"

const last_item_index = markers.length - 1

var map = new mapboxgl.Map({
  container: 'map2',
  style: 'mapbox://styles/mapbox/light-v10',
  center: start, // starting position
  zoom: 12
});
// set the bounds of the map
// var bounds = [[-123.069003, 45.395273], [-122.303707, 45.612333]];
// map.setMaxBounds(bounds);

// initialize the map canvas to interact with later
var canvas = map.getCanvasContainer();

markers.forEach((marker) => {
  new mapboxgl.Marker()
    .setLngLat([marker.lng, marker.lat])
    .addTo(map);
});


function getRoute(endCoords) {
  // make a directions request using cycling profile
  // an arbitrary start will always be the same
  // only the end or destination will change

  var url = "https://api.mapbox.com/directions/v5/mapbox/"

  url += transport_profile + "/"

  if(markers.length > 0) {
    markers.forEach(marker => { url += marker.lng + "," + marker.lat + ";" });
    url = url.slice(0,-1)
    url += '?steps=true&geometries=geojson&access_token=' + mapboxgl.accessToken
  };
  console.log(markers)

  console.log(url)

  // var url = "https://api.mapbox.com/directions/v5/mapbox/cycling/-0.0747088,51.5328915;-0.0775,51.5235693?geometries=geojson&access_token=pk.eyJ1IjoicnViaXh0aGVjdWJpeCIsImEiOiJja213YmVid3EwZGZ2MnZudnI1OGN6Zm9mIn0.o9_KQSxzMvHX53JtF-hX5A"

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


  document.getElementById("route-distance").innerHTML = Math.round(data.distance * 0.001) + "km";
  document.getElementById("route-duration").innerHTML = new Date(data.duration * 1000).toISOString().substr(11, 8);
  // Math.round(data.duration / 3600 ) + "hrs";

  var instruction_number = 1

  data.legs.forEach((leg) => {
      var newDiv = document.createElement("div");
      newDiv.appendChild(document.createTextNode("New Leg"));
      document.getElementById("route-instructions").appendChild(newDiv);

    leg.steps.forEach((step) => {
      var newDiv = document.createElement("div");
      newDiv.appendChild(document.createTextNode(instruction_number + " " + step.maneuver.instruction));
      document.getElementById("route-instructions").appendChild(newDiv);
      instruction_number += 1
      // console.log(step.maneuver.instruction)
    })
  })

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

  map.addLayer({
    id: 'routearrows',
    type: 'symbol',
    source: {
          type: 'geojson',
          data: {
            type: 'Feature',
            properties: {},
            geometry: {
              type: 'LineString',
              coordinates: route
            }
          }
        },
    layout: {
      'symbol-placement': 'line',
      'text-field': '▶',
      'text-size': [
        "interpolate",
        ["linear"],
        ["zoom"],
        12, 24,
        22, 120,
        40, 100
      ],
      'symbol-spacing': [
        "interpolate",
        ["linear"],
        ["zoom"],
        12, 30,
        22, 160,
        40, 200
      ],
      'text-keep-upright': false
    },
    paint: {
      'text-color': '#FFDE55',
      'text-halo-color': 'hsl(55, 11%, 96%)',
      'text-halo-width': 3
    }
  }, 'waterway-label');

    }
  };
  req.send();
}

const mapRoute = () => {
  map.on('load', function() {
  // make an initial directions request that
  // starts and ends at the same location
  getRoute(start);

  // Add starting point to the map
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
  // this is where the code from the next step will go
  var end = {
    type: 'FeatureCollection',
    features: [{
      type: 'Feature',
      properties: {},
      geometry: {
        type: 'Point',
        coordinates: [markers[last_item_index].lng, markers[last_item_index].lat]
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
              coordinates: [markers[last_item_index].lng, markers[last_item_index].lat]
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
  getRoute([markers[last_item_index].lng, markers[last_item_index].lat]);
});
}

document.getElementById("walking").addEventListener("click", function() {
  document.getElementById("walking").className = "round-yellow-button-route";
  document.getElementById("cycling").className = "round-grey-button-route";
  document.getElementById("driving").className = "round-grey-button-route";

  transport_profile = "walking"

  mapRoute();
});

document.getElementById("cycling").addEventListener("click", function() {
  document.getElementById("walking").className = "round-grey-button-route";
  document.getElementById("cycling").className = "round-yellow-button-route";
  document.getElementById("driving").className = "round-grey-button-route";

  transport_profile = "cycling"

  mapRoute();
});

document.getElementById("driving").addEventListener("click", function() {
  document.getElementById("walking").className = "round-grey-button-route";
  document.getElementById("cycling").className = "round-grey-button-route";
  document.getElementById("driving").className = "round-yellow-button-route";

  transport_profile = "driving"

  mapRoute();
});

export { mapRoute };


















