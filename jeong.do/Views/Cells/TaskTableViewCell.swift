//
//  TaskTableViewCell.swift
//  jeong.do
//
//  Created by Yassin Mziya on 6/5/19.
//  Copyright © 2019 Yassin Mziya. All rights reserved.
//

import UIKit
import SnapKit

class TaskTableViewCell: UITableViewCell {

    static let reuseId = "TaskTableViewCell"
    
    var checkImageView: UIImageView = {
        let imgView = UIImageView(image: #imageLiteral(resourceName: "checkbox-empty.png"))
        return imgView
    }()
    
    var taskLabel: UILabel = {
        let label = UILabel()
        label.text = "Take out trash"
        label.textColor = .jeongGray
        label.font = UIFont._12RobotoRegular
        return label
    }()
    
    var trashImageView: UIImageView = {
        let imgView = UIImageView(image: #imageLiteral(resourceName: "trash.png"))
        return imgView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addSubview(checkImageView)
        addSubview(taskLabel)
        addSubview(trashImageView)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(checkImageView)
        addSubview(taskLabel)
        addSubview(trashImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        checkImageView.snp.makeConstraints { make in
            make.centerY.leading.equalToSuperview()
            make.height.width.equalTo(16)
        }
        
        trashImageView.snp.makeConstraints { make in
            make.centerY.height.width.equalTo(checkImageView)
            make.trailing.equalToSuperview().offset(-55)
        }
        
        taskLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkImageView.snp.trailing).offset(12)
            make.trailing.equalTo(trashImageView.snp.leading).offset(-12)
            make.centerY.equalTo(checkImageView)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
