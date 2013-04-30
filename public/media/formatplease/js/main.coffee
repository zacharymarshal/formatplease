$ ->
	download_form = $('#fp-paper-download_form')
	format_button = $('#fp-format_button')
	format_button_message = $('#fp-format_button-message')
	format_button_loading = $('#fp-format_button-loading')

	download_form.submit (e) ->
		e.preventDefault()
		$('#fp-paper-download').html('')
		format_button.prop('disabled', true)
		format_button_loading.html('<i class="icon-spinner icon-spin"></i> ')
		$.post baseUrl(''), $(@).serialize(), (result) ->
			pid = result.pid
			paper_id = result.paper_id
			checkStatus pid, paper_id

	number_of_status_checks = 0
	checkStatus = (pid, paper_id) ->
		number_of_status_checks++
		showLoadingMsg(number_of_status_checks)
		$.get baseUrl("status/#{pid}/#{paper_id}"), {}, (result) ->
			if result.status == 'done'
				return showDownloadLink result.url

			if result.status == 'error'
				return alert('An error has occurred')

			setTimeout(->
				checkStatus(pid, paper_id)
			, 1000)

	showLoadingMsg = (number_of_status_checks) ->
		message = switch
			when number_of_status_checks > 5 then 'Still Formatting...'
			when number_of_status_checks > 10 then 'Wow, still formatting, this is not normal...'
			when number_of_status_checks > 20 then 'Continuing to format ... either you have a really big paper or there are a lot of people using this right now'
			else 'Formatting...'
		format_button_message.html(message)

	showDownloadLink = (download_url) ->
		link = $('<a />').attr(
			'href': download_url,
			'target': '_blank',
			'class': 'button red'
		).html('<i class="icon-download"></i> Download')
		link_input = $('<input />').attr(
			'value': download_url,
			'class': 'fp-download_link_input'
		)
		format_button_loading.html('')
		format_button.removeClass('green')
		format_button_message.html('Format Again')
		format_button.prop('disabled', false)
		$('#fp-paper-download').html("
#{link.prop('outerHTML')}<br /><br /><i class=\"icon-link\"></i> #{link_input.prop('outerHTML')}
		")
		$('.fp-download_link_input').select()



