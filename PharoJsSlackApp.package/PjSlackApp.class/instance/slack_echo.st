routes
slack_echo
	| a json responseLogic |
	a := PjClass new.
	responseLogic := [ :req :res | 
		PjCore log: req.
		PjCore log: '@@@@@@@@@@@'.
		(req query body hasOwnProperty: 'challenge') ifTrue: [
			PjCore log: req query body challenge.
			json := a newFromJsonString: '{ "challenge":','"',req query body challenge,'"',' }'.
			] ifFalse: [
			"make api call to send slack message"
			
			json := a newFromJsonString: '{ "message":"okay" }'.
			].
		res json: json.
	].
	self postRequest: '/echo' response: responseLogic.