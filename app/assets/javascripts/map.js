var map;
var infowindow = null;
var gmarkers = [];
var markerTitles =[];
var highestZIndex = 0;  
var agent = "default";
var zoomControl = true;


// detect browser agent
$(document).ready(function(){
  if(navigator.userAgent.toLowerCase().indexOf("iphone") > -1 || navigator.userAgent.toLowerCase().indexOf("ipod") > -1) {
    agent = "iphone";
    zoomControl = false;
  }
  if(navigator.userAgent.toLowerCase().indexOf("ipad") > -1) {
    agent = "ipad";
    zoomControl = false;
  }
}); 


// resize marker list onload/resize
$(document).ready(function(){
  newHeight = $('html').height() - $('#menu > .wrapper').height();
  $('#list').css('height', newHeight + "px"); 
});
$(window).resize(function() {
  resizeList();
});

// resize marker list to fit window
function resizeList() {
  newHeight = $('html').height() - $('#menu > .wrapper').height();
  $('#list').css('height', newHeight + "px"); 
}


// initialize map
function initialize() {
  // set map styles
  var mapStyles = [
    {
    featureType: "road",
    elementType: "geometry",
    stylers: [
      { hue: "#8800ff" },
      { lightness: 100 }
    ]
  },{
    featureType: "road",
    stylers: [
      { visibility: "on" },
      { hue: "#91ff00" },
      { saturation: -62 },
      { gamma: 1.98 },
      { lightness: 45 }
    ]
  },{
    featureType: "water",
    stylers: [
      { hue: "#005eff" },
      { gamma: 0.72 },
      { lightness: 42 }
    ]
  },{
    featureType: "transit.line",
    stylers: [
      { visibility: "off" }
    ]
  },{
    featureType: "administrative.locality",
    stylers: [
      { visibility: "on" }
    ]
  },{
    featureType: "administrative.neighborhood",
    elementType: "geometry",
    stylers: [
      { visibility: "simplified" }
    ]
  },{
    featureType: "landscape",
    stylers: [
      { visibility: "on" },
      { gamma: 0.41 },
      { lightness: 46 }
    ]
  },{
    featureType: "administrative.neighborhood",
    elementType: "labels.text",
    stylers: [
      { visibility: "on" },
      { saturation: 33 },
      { lightness: 20 }
    ]
  }
  ];

  // set map options
  var myOptions = {
    //zoom: 6,
    //minZoom: 10,
    center: new google.maps.LatLng(12,124), // Adjust to center map
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    panControl: false,
    streetViewControl: false,
    mapTypeControl: false,
    zoomControl: zoomControl,
    styles: mapStyles,
    zoomControlOptions: {
      style: google.maps.ZoomControlStyle.SMALL,
      position: google.maps.ControlPosition.TOP_LEFT
    }
  };

  map = new google.maps.Map(document.getElementById('map_canvas'), myOptions);
  //zoomLevel = map.getZoom();

   var geocoder = new google.maps.Geocoder();

   geocoder.geocode( { 'address': 'philippines'}, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        map.setCenter(results[0].geometry.location);
        map.fitBounds(results[0].geometry.viewport);
      }
    });

  // prepare infowindow
  infowindow = new google.maps.InfoWindow({
    content: "holding..."
  });

  // only show marker labels if zoomed in
  google.maps.event.addListener(map, 'zoom_changed', function() {
    zoomLevel = map.getZoom();
    if(zoomLevel <= 15) {
      $(".marker_label").css("display", "none");
    } else {
      $(".marker_label").css("display", "inline");
    }
  });

  // markers array: name, type (icon), lat, long, description, uri, address
  markers = new Array();

  // DEFINE MARKER HERE

  markers = gon.places;

  // add markers
  jQuery.each(markers, function(i, val) {
    infowindow = new google.maps.InfoWindow({
      content: ""
    });

    // offset latlong ever so slightly to prevent marker overlap
    rand_x = Math.random();
    rand_y = Math.random();
    val[2] = parseFloat(val[2]) + parseFloat(parseFloat(rand_x) / 6000);
    val[3] = parseFloat(val[3]) + parseFloat(parseFloat(rand_y) / 6000);

    // show smaller marker icons on mobile
    if(agent == "iphone") {
      var iconSize = new google.maps.Size(16,19);
    } else {
      iconSize = null;
    }

    // build this marker
    var markerImage = new google.maps.MarkerImage("./images/icons/"+val[1]+".png", null, null, null, iconSize);
    var marker = new google.maps.Marker({
      position: new google.maps.LatLng(val[2],val[3]),
      map: map,
      title: '',
      clickable: true,
      infoWindowHtml: '',
      zIndex: 10 + i,
      icon: markerImage
    });
    marker.type = val[1];
    gmarkers.push(marker);

    markerTitles.push(val[0]); // ENABLE TYPEAHEAD SEARCH

    // add marker hover events (if not viewing on mobile)
    if(agent == "default") {
      google.maps.event.addListener(marker, "mouseover", function() {
        this.old_ZIndex = this.getZIndex(); 
        this.setZIndex(9999); 
        $("#marker"+i).css("display", "inline");
        $("#marker"+i).css("z-index", "99999");
      });
      google.maps.event.addListener(marker, "mouseout", function() { 
        if (this.old_ZIndex && zoomLevel <= 15) {
          this.setZIndex(this.old_ZIndex); 
          $("#marker"+i).css("display", "none");
        }
      }); 
    }

    // format marker URI for display and linking
    var markerURI = val[5];
    if(markerURI.substr(0,7) != "http://") {
      markerURI = "http://" + markerURI; 
    }
    var markerURI_short = markerURI.replace("http://", "");
    markerURI_short = markerURI_short.replace("www.", "");

    // add marker click effects (open infowindow)
    google.maps.event.addListener(marker, 'click', function () {
      if (val[1] == 'event') {
        infowindow.setContent(
          "<div class='marker_title'>"+val[0]+"</div>" +
          "<div class='marker_uri'><a target='_blank' href='"+markerURI+"'>"+markerURI_short+"</a></div>" +
          "<div class='marker_desc'>"+val[4]+"</div>" +
          "<div class='marker_date'>"+val[7]+"</div>" +
          "<div class='marker_address'>"+val[6]+"</div>" );

      }
      else
      {
        infowindow.setContent(
          "<div class='marker_title'>"+val[0]+"</div>" +
          "<div class='marker_uri'><a target='_blank' href='"+markerURI+"'>"+markerURI_short+"</a></div>" +
          "<div class='marker_desc'>"+val[4]+"</div>" +
          "<div class='marker_address'>"+val[6]+"</div>" );
      }
      infowindow.open(map, this);
    });

    // add marker label
    var latLng = new google.maps.LatLng(val[2], val[3]);
    var label = new Label({
      map: map,
      id: i
    });
    label.bindTo('position', marker);
    label.set("text", val[0]);
    label.bindTo('visible', marker);
    label.bindTo('clickable', marker);
    label.bindTo('zIndex', marker);
  });

  // zoom to marker if selected in search typeahead list
  $('#search').typeahead({
    source: markerTitles,
    updater: function(obj) {
      marker_id = jQuery.inArray(obj, markerTitles);
      if(marker_id > -1) {
        goToMarker(marker_id);
      }
      $("#search").val("");
      return obj;
    }
  });

} 


// zoom to specific marker
function goToMarker(marker_id) {
  if(marker_id > -1) {
    map.panTo(gmarkers[marker_id].getPosition());
    map.setZoom(17);
    google.maps.event.trigger(gmarkers[marker_id], 'click');
  }
}

// toggle (hide/show) markers of a given type (on the map)
function toggle(type) {
  if($('#filter_'+type).is('.inactive')) {
    show(type); 
  } else {
    hide(type); 
  }
}

// hide all markers of a given type
function hide(type) {
  for (var i=0; i<gmarkers.length; i++) {
    if (gmarkers[i].type == type) {
      gmarkers[i].setVisible(false);
    }
  }
  $("#filter_"+type).addClass("inactive");
}

// show all markers of a given type
function show(type) {
  for (var i=0; i<gmarkers.length; i++) {
    if (gmarkers[i].type == type) {
      gmarkers[i].setVisible(true);
    }
  }
  $("#filter_"+type).removeClass("inactive");
}

// toggle (hide/show) marker list of a given type
function toggleList(type) {
  $("#list .list-"+type).toggle();
}


// hover on list item
function markerListMouseOver(marker_id) {
  $("#marker"+marker_id).css("display", "inline");
}
function markerListMouseOut(marker_id) {
  $("#marker"+marker_id).css("display", "none");
}

google.maps.event.addDomListener(window, 'load', initialize);
