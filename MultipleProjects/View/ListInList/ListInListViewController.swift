//
//  ListInListViewController.swift
//  MultipleProjects
//
//  Created by Webcash on 2020/04/23.
//  Copyright © 2020 Moonift. All rights reserved.
//

import UIKit

class ListInListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var list : [String : [Any]] = ["Test 1" : ["일\n\n1", "이\n\n\nHello", "삼", "사", "오"],
                   "Test 2" : ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine"],
                   "Test 3" : ["Uno"],
                   "Test 4" : ["123", 345],
                   "Test 5" : [1, 43, 2, 1, 5, 1, 6],
                   "Test 6" : ["asdf", "ㅁㄴㅇㄹ", "qwer", "1234"]]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }


}

// MARK: - extension
extension ListInListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == list.count {
//            addListAlert()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == list.count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddListCell", for: indexPath) as? AddListTableViewCell else {
                return UITableViewCell()
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShowListCell", for: indexPath) as? ListTableViewCell else {
                return UITableViewCell()
            }
            
            let keyList = self.list.keys
            let sortedKeyList = Array(keyList).sorted()
            let key = sortedKeyList[indexPath.row]
            let value = list[key]

            cell.titleLB.text = key
            cell.labelList.removeAll()
            cell.labelList.append(contentsOf: value!)
            
            return cell
        }
    }
    
    func addListAlert() {
        let alert = UIAlertController(title: "리스트 추가", message: "제목과 내용의 개수를 입력해주세요.", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "타이틀"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "리스트 개수"
        }
        
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
            // code
            self.addContentsAlert(title: (alert.textFields?[0].text)!, count: Int((alert.textFields?[1].text)!)!)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        self.present(alert, animated: true)
    }
    
    func addContentsAlert(title: String, count: Int) {
        
        let alert = UIAlertController(title: "\(title) 내용 추가", message: "내용을 입력해주세요.", preferredStyle: .alert)
        
        for index in 0 ..< count {
            alert.addTextField { (textField) in
                textField.placeholder = "내용\(index + 1)..."
            }
        }
        
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
            // code
            var listArray = Array<String>()
            for index in 0 ..< count {
                listArray.append((alert.textFields?[index].text)!)
            }
            self.list[title]?.append(contentsOf: listArray)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        self.present(alert, animated: true)
    }
    
}
