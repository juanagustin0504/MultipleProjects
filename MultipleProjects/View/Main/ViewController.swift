//
//  ViewController.swift
//  MultipleProjects
//
//  Created by Webcash on 2020/04/23.
//  Copyright © 2020 Moonift. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var menu = ["List In List", "Firebase Remote Config"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    

}

// MARK: - extension
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.pushVC(VC(sb: "ListInList", identifier: "ListInListViewController"))
        case 1:
            self.pushVC(VC(sb: "RemoteConfig", identifier: "RemoteConfigViewController"))
        default:
            print("Default")
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as? MenuCell else {
            return UITableViewCell()
        }
        cell.titleLb.text = menu[indexPath.row] + " >"
        return cell
        
    }
    
}

extension UIViewController {
    func pushVC(_ vc: UIViewController, animated: Bool = true) {
        self.navigationController?.pushViewController(vc, animated: animated)
    }
    
    func VC(sb: String, identifier: String) -> UIViewController {
        let sb = UIStoryboard(name: sb, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: identifier)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        return vc
    }
}
