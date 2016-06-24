/* Firebase config should look like this:
module.exports = {
  apiKey: "blah",
  authDomain: "blah.firebaseapp.com",
  databaseURL: "https://blah.firebaseio.com",
  storageBucket: "blah.appspot.com",
  email: "an email for a login already created in firebase admin"
};
*/
var config = require('./secrets/firebase-config.js')
var auth = require('./js/auth')

// Initialize Firebase
firebase.initializeApp(config);

// pull in desired CSS/SASS files
require( './styles/main.scss' );

// inject bundled Elm app into div#main
var Elm = require( './Main' );
var app = Elm.Main.embed( document.getElementById( 'main' ) );

app.ports.logIn.subscribe(auth.signIn.bind(null, app, config.email))
firebase.auth().onAuthStateChanged(auth.onStateChanged.bind(null, app))
app.ports.logOut.subscribe(auth.signOut.bind(null, app))
