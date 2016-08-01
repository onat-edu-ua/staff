$ ->
  # enable chosen js
  $('select.chosen').chosen
    allow_single_deselect: true
    no_results_text: 'No results matched'
    width: '240px'

  $("select.chosen-wide").chosen
    no_results_text: 'No results matched'
    width: '80%'

  $("select.chosen-sortable").chosen({no_results_text: 'No results matched', width: '80%'}).chosenSortable()