import UIKit
import Flutter
import GoogleMaps


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let path = Bundle.main.path(forResource: "Keys", ofType: "plist")
    let plist = NSDictionary(contentsOfFile:path!)
    let value = plist?.object(forKey: "googleApiKey") as! String

    GMSServices.provideAPIKey(value)
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

}

