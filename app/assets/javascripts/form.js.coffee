$ ->
  $(".form-date").hide()

  $("#place_type").change ->
    console.log $("#place_type option:selected").text()
    if $("#place_type option:selected").text() is "Events"
      console.log $("#place_type option:selected").text()
      $(".form-date").slideToggle()
    else
      $(".form-date").hide("slide")
