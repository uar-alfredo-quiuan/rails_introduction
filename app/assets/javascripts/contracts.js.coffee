# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@clear_previous_errors = ->
	$('#modal-window .modal-body .errors-section').html('')
@clear_previous_delete_errors = ->
	$('body .container div.alert-danger').remove()
@render_form_errors = (errors) ->
	clear_previous_errors();
	ul = $(document.createElement('ul')).addClass('alert alert-danger')
	for error in errors.errors
		do ->
			li = $(document.createElement('li')).text(error).appendTo(ul)
	$('#modal-window .modal-body .errors-section').append(ul)
@render_table_merchandise = (merchandise) ->
	tr = $(document.createElement('tr')).attr('id', 'row_' + merchandise.id)
	tr.append($(document.createElement('td')).text(merchandise.name))
	tr.append($(document.createElement('td')).addClass('text-right').text(parseFloat(merchandise.price)))
	$('table.merchandise-table').find('tr:last').prev().after(tr)
	url_edit = '/contracts/' + merchandise.contract_id + '/merchandises/' + merchandise.id + '/edit'
	a_edit = $(document.createElement('a')).attr('href', url_edit ).text('Edit')
	tr.append($(document.createElement('td')).addClass('text-right').append(a_edit))
	url_delete = '/contracts/' + merchandise.contract_id + '/merchandises/' + merchandise.id
	attr = { "href": url_delete, "data-confirm": "Are you sure?", "data-method": "delete", "data-remote": "true" }
	a_delete = $(document.createElement('a')).addClass('destroy').attr( attr ).text('Destroy')
	tr.append($(document.createElement('td')).addClass('text-right').append(a_delete))
	amount = $('td.amount', $('table.merchandise-table').find('tr:last'))
	amount.text(parseFloat(amount.text()) + parseFloat(merchandise.price))
	$('table.merchandise-table').find('tr:last').prev().after(tr)
	balance = $('span.badge')
	balance.text(parseFloat(balance.text()) + parseFloat(merchandise.price))
@remove_table_merchandise = (merchandise) ->
	clear_previous_delete_errors()
	$("#row_#{merchandise.id}", ".table.merchandise-table").remove();
	amount = $('td.amount', $('table.merchandise-table').find('tr:last'));
	amount.text(parseFloat(amount.text()) - parseFloat(merchandise.price));
	balance = $('span.badge');
	balance.text(parseFloat(balance.text()) - parseFloat(merchandise.price));
@render_delete_errors = (error) ->
	clear_previous_delete_errors();
	p = $(document.createElement('p')).text(error)
	div = $(document.createElement('div')).addClass('alert alert-danger').append(p)
	$('body .container').append(div)
$(document).on 'turbolinks:load', ->
  if ($('table.payment-table').length)
	  $('#modal-window').on 'shown.bs.modal', ->
		  clear_previous_errors()
  $(document).on 'ajax:error', 'form.merchandise-form', (event, jqxhr, settings, exception) ->
	  render_form_errors( $.parseJSON(jqxhr.responseText) )
  $(document).on 'ajax:success', 'form.merchandise-form', (event, jqxhr, settings, exception) ->
	  $('#modal-window').modal('hide')
	  render_table_merchandise( jqxhr.merchandise )
  $(document).on 'ajax:success', '.destroy', (event, jqxhr, settings, exception) ->
	  remove_table_merchandise( jqxhr.merchandise )
  $(document).on 'ajax:error', '.destroy', (event, jqxhr, settings, exception) ->
	  render_delete_errors( $.parseJSON(jqxhr.responseText).error )