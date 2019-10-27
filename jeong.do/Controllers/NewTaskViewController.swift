//
//  NewTaskViewController.swift
//  jeong.do
//
//  Created by Yassin Mziya on 6/5/19.
//  Copyright © 2019 Yassin Mziya. All rights reserved.
//

import UIKit

class NewTaskViewController: UIViewController {
    
    var promptLabel: UILabel = {
        let label = UILabel()
        label.text = "What would you like to do?"
        label.textColor = .jeongLightGray
        label.font = UIFont._12RobotoRegular
        return label
    }()
    
    var taskField: UITextField = {
        let field = UITextField()
        field.font = UIFont._24RobotoRegular
        field.textColor = .jeongDarkGray
        return field
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
        // transitioningDelegate = self
        
        view.addSubview(promptLabel)
        view.addSubview(taskField)
        view.addSubview(addTaskButton)
        setupConstraints()
        setupObservers()
        
        taskField.becomeFirstResponder()
    }
    

    func setupConstraints() {
        promptLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(55)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(32)
        }
        
        taskField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(promptLabel)
            make.top.equalTo(promptLabel.snp.bottom).offset(4)
        }
        
        addTaskButton.snp.makeConstraints { make in
            make.height.width.equalTo(56)
            // make.leading.trailing.equalToSuperview()
            make.trailing.equalToSuperview().offset(-25)
            make.bottom.equalToSuperview().offset(-64)
        }
    }
    
    func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

// MARK:- Helpers
extension NewTaskViewController {
    
    @objc func keyboardWillChange(notification: NSNotification) {
        print("Keyboard will show: \(notification.name.rawValue)")
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { return }
        guard let keyboardAnimationDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue else { return }
        guard let keyboardAnimationCurve = (notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue else { return }
        
        UIView.animate(withDuration: keyboardAnimationDuration,
                       delay: 0,
                       options: UIView.AnimationOptions(rawValue: keyboardAnimationCurve << 16),
                       animations: {
                        self.addTaskButton.snp.updateConstraints({ make in
                            make.bottom.equalToSuperview().offset(64 +  keyboardSize.height)
                        })
                        self.addTaskButton.layoutIfNeeded()
        }, completion: nil)
    }
    
}
