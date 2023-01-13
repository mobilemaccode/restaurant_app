import UIKit
import Flutter
import GoogleMaps


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyAXhVfxiurmIRiVfSeIe_rOdpYTdHuoFaw")
    GeneratedPluginRegistrant.register(with: self)

    [GeneratedPluginRegistrant registerWithRegistry:self];
    [GMSServices provideAPIKey:@"AIzaSyAXhVfxiurmIRiVfSeIe_rOdpYTdHuoFaw"];


    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
