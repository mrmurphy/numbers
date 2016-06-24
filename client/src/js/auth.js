module.exports = {
  signIn: function(app, email, password) {
    firebase.auth()
      .signInWithEmailAndPassword(email, password)
      .catch(function(error) {
        app.ports.loginError.send(error.message)
      })
  },
  onStateChanged: function(app, user) {
    if (user) {
      app.ports.loggedIn.send(true)
    } else {
      window.location.hash = "login?redirectTo=" + (
        window.location.hash.indexOf('#login') == -1 ? window.location.hash : "")
    }
  },
  signOut: function(app) {
    // TODO: Differenciate between logging out and being in a logged out state, so that the user can know that the logout was successful.
    firebase.auth()
    .signOut().then(function() {
      app.ports.loggedIn.send(false)
    })
  }
}
