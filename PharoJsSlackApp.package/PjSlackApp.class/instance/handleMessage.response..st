routes
handleMessage: req response: res
	| json |
	json := { #message -> 'okay' }.
	res json: json asDictionary.
