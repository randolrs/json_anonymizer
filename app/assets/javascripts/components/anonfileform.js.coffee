@AnonFileForm = React.createClass
	getInitialState: ->
		name: ''
	handleChange: (e) ->
		name = e.target.name
		@setState "#{ name }": e.target.value
	valid: ->
		@state.name && @state.upload_file
	handleSubmit: (e) ->
		e.preventDefault()
		$.post '/import_file', { anonFile: @state }, (data) =>
			@props.handleNewAnonFile data
			@setState @getInitialState()
		, 'JSON' 
		alert("Success")
	render: ->
		React.DOM.form
			onSubmit: @handleSubmit
			React.DOM.field
				React.DOM.input
					type: 'text'
					placeholder: 'Name'
					name: 'name'
					value: @state.name
					onChange: @handleChange
			React.DOM.field
				React.DOM.input
					type: 'file'
					name: 'upload_file'
					value: @state.upload_file
					onChange: @handleChange
			React.DOM.button
				type: 'submit'
				className: 'btn btn-primary'
				disabled: !@valid()
				'Upload and Anonymize'