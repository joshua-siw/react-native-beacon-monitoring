import CoreLocation
import React

@objc(BeaconMonitoring)
class BeaconMonitoring: RCTEventEmitter, CLLocationManagerDelegate {

  var locationManager: CLLocationManager?
  var beaconRegion: CLBeaconRegion?

  override init() {
    super.init()
    locationManager = CLLocationManager()
    locationManager?.delegate = self
  }

    @objc func startMonitoring(_ uuid: String, identifier: String, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        guard let beaconUUID = UUID(uuidString: uuid) else {
          reject("BeaconMonitoringError", "Invalid UUID", nil)
          return
        }

        beaconRegion = CLBeaconRegion(uuid: beaconUUID, identifier: identifier)
        if let beaconRegion = beaconRegion {
          locationManager?.startMonitoring(for: beaconRegion)
          resolve("Started monitoring for beacon region")
        } else {
          reject("BeaconMonitoringError", "Failed to create beacon region", nil)
        }
    }

    @objc func stopMonitoring(resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
    if let beaconRegion = beaconRegion {
      locationManager?.stopMonitoring(for: beaconRegion)
      resolve("Stopped monitoring beacon region")
    } else {
      reject("BeaconMonitoringError", "No beacon region to stop monitoring", nil)
    }
  }

  func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
    if region is CLBeaconRegion {
      sendEvent(withName: "didEnterRegion", body: ["identifier": region.identifier])
    }
  }

  func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
    if region is CLBeaconRegion {
      sendEvent(withName: "didExitRegion", body: ["identifier": region.identifier])
    }
  }

  override func supportedEvents() -> [String]! {
    return ["didEnterRegion", "didExitRegion"]
  }

  override static func requiresMainQueueSetup() -> Bool {
    return false
  }
}
