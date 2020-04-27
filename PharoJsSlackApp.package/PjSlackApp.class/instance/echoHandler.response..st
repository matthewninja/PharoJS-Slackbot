handlers
echoHandler: req response: res
	| reply_msg incoming_msg user_id |
	user_id := req body event text.
	incoming_msg := ((req body event text) js_split: ' ').
	incoming_msg remove: '<@UTLBEEGHH>'.
	incoming_msg := incoming_msg js_join: ' '.
	
	(incoming_msg includes: 'install') 
		ifTrue: [ 
			PjCore log: 'install question'.
			reply_msg := { #json -> { #text -> 'Install can be done inside a Pharo 7 image (https://pharo.org/download/) by evaluating the following in a playground:

```
Metacello new 
    baseline: ''PharoJS'';
    repository: ''github://PharoJS/PharoJS'';
    load
```

Upon install, Pharo will download HTML code for examples. They are located in a folder along with the image and the change files. This is: pharo-local/iceberg/PharoJS/PharoJS/HTML It contains subfolders for each example and test.' } asDictionary } asDictionary.
			 ]
		ifFalse: [ 
			PjCore log: 'FAQ not related to installation'.
			reply_msg := { #json -> { #text -> incoming_msg } asDictionary } asDictionary.
			 ].
	
	
	"PjCore log: reply_msg."
	Requestjs post: webhook_url with: reply_msg callback: [ :response :body |
		"PjCore log: body."
		 ].

	res json: { #message -> 'okay' } asDictionary.
