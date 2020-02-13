routes
slack: route handler: handleMessage
	| responseLogic |
	responseLogic := [ :req :res | 
		PjCore log: (req body hasOwnProperty: 'challenge').
		PjCore log: '@@@@@@@@@@@'.
		req body at: #challenge ifPresent: [: value |
			PjCore log: value.
			res json: { #challenge -> value } asDictionary.
		] ifAbsent: [
			"make api call to send slack message"
			self perform: handleMessage with: req with: res
		].
	].
	self postRequest: '/',route response: responseLogic.