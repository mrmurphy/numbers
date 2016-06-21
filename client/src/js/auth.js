module.exports = {
  signIn: function(app, email, password) {
    firebase.auth()
      .signInWithEmailAndPassword(config.email, password)
      .catch(function(error)) {
        app.ports.signInError.send(error.message)
      }
  },
  onStateChanged: function(app, user) {
    if (user) {
      app.ports.loggedIn.send(true)
    }
  }
}
