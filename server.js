/*
 * Module dependencies
 */
var express = require('express');
var stylus = require('stylus');
var nib = require('nib');
var nodemon = require('nodemon');
var fs = require('fs');
var app = express();
var jsonParser = bodyParser.json()
var http = require('http');
function compile(str, path) {
  return stylus(str)
    .set('filename', path)
    .use(nib())
}
app.set('views', __dirname + '/views')
app.set('view engine', 'jade')
app.use(express.bodyParser());
app.get('/', function (req, res) {
  res.end('GPi0Yu0T1(Internet Access Denied/Security Clearance Below Standard)')
})
app.post('/login',function(req,res){
  var user_name=req.body.user;
  var password=req.body.password;
  console.log("User name = "+user_name+", password is "+password);
  res.end("yes");
});
app.set('port', process.env.OPENSHIFT_NODEJS_PORT || process.env.PORT || 8080);
app.set('ip', process.env.OPENSHIFT_NODEJS_IP || "127.0.0.1");
http.createServer(app).listen(app.get('port') ,app.get('ip'), function (req, res) {
  console.log("✔ Express server listening at %s:%d ", app.get('ip'),app.get('port'));
  
});
