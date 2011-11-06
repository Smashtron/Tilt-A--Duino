var io = require('socket.io').listen(8888);
io.sockets.on('connection', function (socket) {
	console.log('Well Hello');
});
var output = "";

var SerialPort = require("serialport").SerialPort;
var serial_port = new SerialPort("/dev/tty.usbmodemfd121", {baudrate: 19200});
serial_port.on("data", function (data) {
	var newString = data.toString('ascii');
	for(var i = 0; i < newString.length; i++) {
		if(newString[i]==";") {
			io.sockets.clients().forEach(function (socket) { socket.emit('nunchuck',output) });
			output = "";
		} else {
			output += newString[i];
		}
	}

})

serial_port.on("error", function (msg) {
  console.log("error: "+msg);
})

//serial_port.close();