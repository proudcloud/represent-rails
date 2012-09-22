$ ->
  if $("place_type option:selected").text() is not "Events"
    $(".form-date").hide()

  $("#place_date").datepicker({dateFormat: "D, MM dd, yy"})

  $("#place_type").change ->
    if $("#place_type option:selected").text() is "Events"
      console.log $("#place_type option:selected").text()
      $(".form-date").slideToggle()
      $("#place_date").attr("required", "required")
    else
      if $("#place_date").is(":visible")
        $(".form-date").hide("slide",{direction: "up"})
        $("#place_date").removeAttr("required", "required")
  

