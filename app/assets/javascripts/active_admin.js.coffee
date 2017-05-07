#= require active_admin/base
#= require active_material
#= require selectize
#= require activeadmin-ajax_filter
#= require palette-color-picker
#= require select2
#= require select2_locale_es
#= require country_state_select
#= require chosen-jquery
$(document).ready ->
  $('.color-picker').paletteColorPicker()
  $( ".select2" ).select2({theme: "bootstrap"}) if window.location.pathname.match(/(items\/.*\/edit|users\/.*\/edit)/)?
  CountryStateSelect({
    country_id: "item_country", state_id: "item_state", city_id: "item_city",
    chosen_ui: true,
    chosen_options: {
      disable_search_threshold: 10,
      width: '65%',
      city_place_holder: "Selecciona una ciudad", state_place_holder: 'Selecciona una región'
    }
  })