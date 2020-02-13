handlers
echoHandler: req response: res
	| reply_msg incoming_msg user_id |
	user_id := req body event text.
	incoming_msg := ((req body event text) js_split: ' ').
	incoming_msg remove: '<@UTLBEEGHH>'.
	incoming_msg := incoming_msg js_join: ' '.
	reply_msg := { #json -> { #text -> incoming_msg } asDictionary } asDictionary.
	Requestjs post: webhook_url with: reply_msg callback: [ :response :body |
		"Object log: body."
		 ].

	res json: { #message -> 'okay' } asDictionary.
