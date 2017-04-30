#= require active_admin/base
#= require active_material
#= require selectize
#= require activeadmin-ajax_filter
#= require palette-color-picker
$(document).ready ->
  $('.color-picker').paletteColorPicker()
  #$( "select" ).select2({theme: "bootstrap"});