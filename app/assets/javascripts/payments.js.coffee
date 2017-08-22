# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#$(window).load ->
@datepicker = ->
   $('#payment_payment_date').datepicker({ dateFormat: 'yy-mm-dd' })
$(document).on 'turbolinks:load', ->
  if ($('form.paymmernt-form').length)
    datepicker()

  if ($('table.payment-table').length)
    $('#modal-window').on 'shown.bs.modal', ->
      datepicker()
