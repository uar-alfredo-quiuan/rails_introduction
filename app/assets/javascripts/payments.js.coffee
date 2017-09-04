# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#$(window).load ->
@datepicker = ->
   $('#payment_payment_date').datepicker({ dateFormat: 'yy-mm-dd' })
@clear_previous_errors = ->
	$('#modal-window .modal-body .errors-section').html('')
@render_form_errors = (errors) ->
	clear_previous_errors();
	ul = $(document.createElement('ul')).addClass('alert alert-danger')
	for error in errors.errors
		do ->
			li = $(document.createElement('li')).text(error).appendTo(ul)
	$('#modal-window .modal-body .errors-section').append(ul)
@render_table_payment = (payment) ->
	tr = $(document.createElement('tr'))
	tr.append($(document.createElement('td')).text(payment.payment_date))
	tr.append($(document.createElement('td')).text(payment.description))
	tr.append($(document.createElement('td')).addClass('text-right').text(parseFloat(payment.amount)))
	a_edit = $(document.createElement('a')).attr('href', '/contracts/' + payment.contract_id + '/payments/' + payment.id + '/edit').text('Edit')
	tr.append($(document.createElement('td')).addClass('text-right').append(a_edit))
	url = '/contracts/' + payment.contract_id + '/payments/' + payment.id
	a_delete = $(document.createElement('a')).attr('href', url).text('Destroy').data({ confirm: "Are you sure?", method: "delete!" } )
	tr.append($(document.createElement('td')).addClass('text-right').append(a_delete))
	amount = $('td.amount', $('table.payment-table').find('tr:last'))
	amount.text(parseFloat(amount.text()) + parseFloat(payment.amount))
	$('table.payment-table').find('tr:last').prev().after(tr)
$(document).on 'turbolinks:load', ->
  if ($('form.paymmernt-form').length)
    datepicker()

  if ($('table.payment-table').length)
	  $('#modal-window').on 'shown.bs.modal', ->
		  datepicker()
		  clear_previous_errors()
  $(document).on 'ajax:error', 'form.payment-form', (event, jqxhr, settings, exception) ->
	  render_form_errors( $.parseJSON(jqxhr.responseText) )
  $(document).on 'ajax:success', 'form.payment-form', (event, jqxhr, settings, exception) ->
	  $('#modal-window').modal('hide')
	  render_table_payment( jqxhr.payment )
