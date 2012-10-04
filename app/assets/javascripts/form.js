
/*
$ ->
  if $("#place_type option:selected").text() != "Events" 
    $(".form-date").hide()

$("#place_date").datepicker({dateFormat: "D, MM dd, yy"})

$("#place_type").change ->
  alert 'hello'
  if $("#place_type option:selected").val() is "event"
    $(".form-date").slideToggle()
    console.log $("#place_type option:selected").text()
    $("#place_date").attr("required", "required")
  else
    if $("#place_date").is(":visible")
      $(".form-date").slideToggle()
      $("#place_date").removeAttr("required", "required")
*/
