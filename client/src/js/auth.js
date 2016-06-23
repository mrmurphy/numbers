module.exports = {
  signIn: function(app, email, password) {
    console.log('signing in with email and password', email, password)
    firebase.auth()
      .signInWithEmailAndPassword(email, password)
      .catch(function(error) {
        app.ports.loginError.send(error.message)
      })
  },
  onStateChanged: function(app, user) {
    if (user) {
      app.ports.loggedIn.send(true)
    }
  }
}
