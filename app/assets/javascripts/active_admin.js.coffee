#= require active_admin/base
#= require active_material
#= require selectize
#= require activeadmin-ajax_filter
#= require palette-color-picker
#= require select2
#= require select2_locale_es

$(document).ready ->
  $('.color-picker').paletteColorPicker()
  $( "select" ).select2({theme: "bootstrap"}) if window.location.pathname.match(/\/(items|users)\//)?