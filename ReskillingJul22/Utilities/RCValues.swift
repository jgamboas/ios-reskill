//
//  RCValues.swift
//  ReskillingJul22
//
//  Created by Andres Carmona Ortiz on 18/08/22.
//

import UIKit
import FirebaseRemoteConfig

enum ValueKey: String {
    case appPrimaryColor
    case showAnimalDetailFeature
}

class RCValues {
    
    //MARK: Properties
    static let sharedInstance = RCValues()
    var loadingDoneCallback: (() -> Void)?
    var fetchComplete = false
    
    private init() {
        loadDefaultValues()
        fetchCloudValues()
    }
    
    func loadDefaultValues() {
        let appDefaults: [String: Any?] =  [
            ValueKey.appPrimaryColor.rawValue : "#FBB03B",
            ValueKey.showAnimalDetailFeature.rawValue: false
        ]
        RemoteConfig.remoteConfig().setDefaults(appDefaults as? [String: NSObject])
    }
    
    func activateDebugMode() {
        let settings = RemoteConfigSettings()
        //WARNING: Don't actually do this in production!
        settings.minimumFetchInterval = 0
        RemoteConfig.remoteConfig().configSettings = settings
    }
    
    func fetchCloudValues() {
        
        activateDebugMode()
     
        RemoteConfig.remoteConfig().fetch { (status, error) -> Void in
            if status == .success {
                RemoteConfig.remoteConfig().activate { changed, error in
                    self.fetchComplete = true
                }
            } else {
                print("Config not fetched")
                print("Error: \(error?.localizedDescription ?? "No error available.")")
            }
            DispatchQueue.main.async {
                self.loadingDoneCallback?()
            }
        }
        
    }
    
    func color(forKey key: ValueKey) -> UIColor {
        let colorAsHexString = RemoteConfig.remoteConfig().configValue(forKey: key.rawValue)
            .stringValue ?? "#FFFFFF"
        print(colorAsHexString)
        let convertedColor = UIColor(hexString: colorAsHexString) ?? UIColor.white
        return convertedColor
    }
    
    func bool(forKey key: ValueKey) -> Bool {
      RemoteConfig.remoteConfig()[key.rawValue].boolValue
    }
}
