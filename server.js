/*
 * Module dependencies
 */
var express = require('express')
	, stylus = require('stylus')
	, nib = require('nib')
	, nodemon = require('nodemon')
    , fs = require('fs')
var app = express()
var http = require('http');
function compile(str, path) {
  return stylus(str)
    .set('filename', path)
    .use(nib())
}
app.set('views', __dirname + '/views')
app.set('view engine', 'jade')
app.use(express.logger('dev'))
app.use(stylus.middleware(
  { src: __dirname + '/public'
  , compile: compile
  }
))
app.use(express.static(__dirname + '/public'))
app.get('/', function (req, res) {
  res.end('GPi0Yu0T1(Internet Access Denied/Security Clearance Below Standard)')
})
app.set('port', process.env.OPENSHIFT_NODEJS_PORT || process.env.PORT || 8080);
app.set('ip', process.env.OPENSHIFT_NODEJS_IP || "127.0.0.1");
http.createServer(app).listen(app.get('port') ,app.get('ip'), function (req, res) {
  console.log("✔ Express server listening at %s:%d ", app.get('ip'),app.get('port'));
  app.use(express.bodyParser());
  app.get('/', function(req, res){
    console.log('GET /');
    //var html = '<html><body><form method="post" action="http://localhost:3000">Name: <input type="text" name="name" /><input type="submit" value="Submit" /></form></body>';
    var html = fs.readFileSync('index.html');
    res.writeHead(200, {'Content-Type': 'text/html'});
    res.end(html);
  });
  app.post('/', function(req, res){
    console.log('POST /');
    console.dir(req.body);
    res.writeHead(200, {'Content-Type': 'text/html'});
    res.end('thanks');
  });
});
