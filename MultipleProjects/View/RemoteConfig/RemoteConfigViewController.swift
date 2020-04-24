//
//  RemoteConfigViewController.swift
//  MultipleProjects
//
//  Created by Webcash on 2020/04/24.
//  Copyright © 2020 Moonift. All rights reserved.
//

import UIKit
import FirebaseRemoteConfig

class RemoteConfigViewController: UIViewController {
    
    // MARK: Server parameter keys
//    let welcomeMessageKey = "welcome_message"
//    let welcomeMessageCapsKey = "welcome_message_caps"
    let lastestVersionKey = "lastest_version"
    let appAvailableKey = "app_available"
    
    // Remote Config
    var remoteConfig: RemoteConfig!
    
    // MARK: - Outlet
    @IBOutlet weak var welcomeLb: UILabel!
    @IBOutlet weak var lastestVersionLb: UILabel!
    @IBOutlet weak var fetchBtn : UIButton!

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
        
        fetchConfig()
        
    }
    
    // MARK: - Custom method
    func fetchConfig() {
//        welcomeLb.text = remoteConfig[welcomeMessageKey].stringValue
//        lastestVersionLb.text = remoteConfig[lastestVersionKey].stringValue
        let expirationDuration = 0 // 1 hour, 60 minutes, 3600 seconds
//
        
        remoteConfig.fetch(withExpirationDuration: TimeInterval(expirationDuration)) { (status, error) in
            if status == .success {
                print("Config fetched!")
                self.remoteConfig.activate { (error) in
                    // ...
                    DispatchQueue.main.async {
                        self.welcomeLb.text = String(self.remoteConfig[self.appAvailableKey].boolValue)
                        self.lastestVersionLb.text = self.remoteConfig[self.lastestVersionKey].stringValue
                    }

                }
            } else {
                print("Config not fetched")
                print("Error: \(error?.localizedDescription ?? "No error available.")")
            }
            self.displayWelcome()
        }
    }
    
    func displayWelcome() {
        print("DisplayWelcome!")
//        var welcomeMessage = remoteConfig[welcomeMessageKey].stringValue
        let version = remoteConfig[lastestVersionKey].stringValue
        let appAvailable = remoteConfig[appAvailableKey].boolValue
        lastestVersionLb.text = version
        welcomeLb.text = String(appAvailable)

        if !remoteConfig[appAvailableKey].boolValue {
            let alert = UIAlertController(title: "안내", message: "앱 사용 불가 알림", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .cancel) { (action) in
                exit(0)
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
//            welcomeMessage = welcomeMessage?.uppercased()
        }
//        welcomeLb.text = welcomeMessage
    }

    // MARK: - Action
    @IBAction func fetchBtnTapped(_ sender: UIButton) {
        fetchConfig()
    }

}
