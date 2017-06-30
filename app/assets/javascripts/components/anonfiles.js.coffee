@AnonFiles = React.createClass
	getInitialState: ->
		anonFiles: []
	getDefaultProps: ->
		anonFiles: []
	addAnonFile: (anonFile) ->
		anonFiles = @state.anonFiles.slice()
		anonFiles.push anonFile
		@setState anonFiles: anonFiles
	render: ->
		React.DOM.div
			className: 'anon-files'
			React.DOM.table
				className: 'file-table'
				React.DOM.tbody null,
					React.DOM.tr null,
						React.DOM.th
							className: 'table-label'
							'Name'
						React.DOM.th
							className: "table-label"
							'Entries'
						React.DOM.th null
					for offer in @state.anonFiles
						React.createElement anonFile, key: anonFile.id, anonFile: anonFile
