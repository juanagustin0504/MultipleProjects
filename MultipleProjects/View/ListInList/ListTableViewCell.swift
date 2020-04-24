//
//  ListTableViewCell.swift
//  ListInList
//
//  Created by Webcash on 2020/04/17.
//  Copyright © 2020 Moonift. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    var labelList: Array<Any> = Array<Any>() {
        didSet {
            for subView in stackView.subviews {
                subView.removeFromSuperview()
            }
            settingLayout()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }
    
    func settingLayout() {
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
//                stackView.alignment = .center
        stackView.spacing = 10

        for index in 0 ..< labelList.count {
            print("index\(labelList.count) : \(index)")
            let label = UILabel()
            label.text = "· \(labelList[index] )"
            label.lineBreakMode = .byWordWrapping
            self.stackView.addArrangedSubview(label)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class AddListTableViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()        
        selectionStyle = .none
    }
}
