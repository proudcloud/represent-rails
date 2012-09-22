$ ->
  $(".form-date").hide()

  $("#place_date").datepicker()

  $("#place_type").change ->
    console.log $("#place_type option:selected").text()
    if $("#place_type option:selected").text() is "Events"
      console.log $("#place_type option:selected").text()
      $(".form-date").slideToggle()
      $("#place_date").attr("required", "required")
    else
      $(".form-date").hide("slide")
      $("#place_date").removeAttr("required", "required")
