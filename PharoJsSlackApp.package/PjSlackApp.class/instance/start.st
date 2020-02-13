routes
start
	super start.
	"bodyParser := BodyParser new."
	expressServer use: BodyParser json.
	self slack: #echo handler: #handleMessage:response:.
	self listen: 3000.
	^ expressServer.