Experience MyLocation {
    Decision startBtn action("MainContext.hasGPS") label("HAS GPS?")
    Decision getLocation action("MainContext.getLocation") label("GET USER LOCATION")
}

Application {
   OnInit {
        broker.ui.push("MyLocation")
        try {
            broker.location.start()
        } catch (e) {
            broker.ui.showAlert("Error", e.reason())
        }
    }
}

RuleContext MainContext {

    Rule hasGPS {
        try {
            Bool hasGPS = broker.location.hasGPS()
            broker.ui.showAlert("Location", "Has GPS: " + hasGPS.toString())
        } catch (e) {
            broker.ui.showAlert("Error", e.reason())
        }
    }

    Rule getLocation {
        try {
            Location userLoc = broker.location.getLocation()
            broker.ui.showAlert("Device Location", "(" + userLoc.latitude + ","+ userLoc.longitude + ")")
        } catch (e) {
            broker.ui.showAlert("Error", e.reason())
        }
    }
}