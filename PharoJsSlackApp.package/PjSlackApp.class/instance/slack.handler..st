routes
slack: route handler: handleMessage
	| responseLogic |
	responseLogic := [ :req :res | 
		PjCore log: 'response logic executing'.
		req body at: #challenge ifPresent: [: value |
			res json: { #challenge -> value } asDictionary.
		] ifAbsent: [
			self perform: handleMessage with: req with: res
		].
	].
	self postRequest: '/',route response: responseLogic.