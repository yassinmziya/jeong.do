//
//  GroupViewController.swift
//  jeong.do
//
//  Created by Yassin Mziya on 6/4/19.
//  Copyright © 2019 Yassin Mziya. All rights reserved.
//

import UIKit
import SnapKit

class GroupViewController: UIViewController {
    
    var glyphImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.backgroundColor = .lightGray
        imgView.layer.cornerRadius = 24
        imgView.clipsToBounds = true
        return imgView
    }()
    
    var metadataLabel: UILabel = {
        let metadata = NSMutableAttributedString(string: "12 Tasks", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.jeongLightGray,
            NSAttributedString.Key.font: UIFont._16RobotoRegular!,
            ])
        
        let groupName = NSMutableAttributedString(string: "\nWork", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.jeongDarkGray,
            NSAttributedString.Key.font: UIFont._36RobotoRegular!
            ])
        
        metadata.append(groupName)
        
        
        let label = UILabel()
        label.numberOfLines = 2
        label.attributedText = metadata
        
        return label
    }()
    
    var progressBarView: ProgressBarView = {
        return ProgressBarView()
    }()
    
    var tasksTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.reuseId)
        tableView.tableFooterView = UIView()
        tableView.separatorColor = UIColor.init(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        return tableView
    }()
    
    var addTaskButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "plus"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        btn.layer.cornerRadius = 56/2
        btn.backgroundColor = .jeongBlue
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(glyphImageView)
        view.addSubview(metadataLabel)
        view.addSubview(progressBarView)
        
        tasksTableView.dataSource = self
        view.addSubview(tasksTableView)

        view.addSubview(addTaskButton)
        addTaskButton.addTarget(self, action: #selector(addNewTask), for: .touchUpInside)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        glyphImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40 + 50)
            make.leading.equalTo(55)
            make.height.width.equalTo(48)
        }
        
        metadataLabel.snp.makeConstraints { make in
            make.leading.equalTo(glyphImageView)
            make.top.equalTo(glyphImageView.snp.bottom).offset(32)
        }
        
        progressBarView.snp.makeConstraints { make in
            make.leading.equalTo(metadataLabel)
            make.trailing.equalToSuperview().offset(-55)
            make.top.equalTo(metadataLabel.snp.bottom).offset(16)
            make.height.equalTo(24)
        }
        
        tasksTableView.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview()
            make.leading.equalTo(progressBarView)
            make.top.equalTo(progressBarView.snp.bottom).offset(36)
        }
        
        addTaskButton.snp.makeConstraints { make in
            make.height.width.equalTo(56)
            make.trailing.equalToSuperview().offset(-25)
            make.bottom.equalToSuperview().offset(-64)
        }
    }

}

// MARK:- UITableViewDataSource
extension GroupViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tasksTableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.reuseId) as! TaskTableViewCell
        return cell
    }
    
}

// MARK:- HELPERS
extension GroupViewController {
    
    @objc func addNewTask() {
        navigationController?.pushViewController(NewTaskViewController(), animated: true)
    }
    
}
