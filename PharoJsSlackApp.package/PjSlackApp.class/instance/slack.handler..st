routes
slack: route handler: handleMessage
	| responseLogic |
	responseLogic := [ :req :res | 
		req body at: #challenge ifPresent: [: value |
			PjCore log: value.
			res json: { #challenge -> value } asDictionary.
		] ifAbsent: [
			self perform: handleMessage with: req with: res
		].
	].
	self postRequest: '/',route response: responseLogic.