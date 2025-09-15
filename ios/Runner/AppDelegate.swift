import UIKit
import Flutter
import GoogleMaps // ✅ Add this if using Maps
import GooglePlaces // ✅ Add this if using Places Autocomplete

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    GMSServices.provideAPIKey("AIzaSyBCmerxcaXPKBt1nc1X6of7AIP1MQw5Ifk")
    GMSPlacesClient.provideAPIKey("AIzaSyBCmerxcaXPKBt1nc1X6of7AIP1MQw5Ifk")

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
