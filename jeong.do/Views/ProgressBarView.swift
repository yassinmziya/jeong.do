//
//  ProgressBarView.swift
//  jeong.do
//
//  Created by Yassin Mziya on 6/4/19.
//  Copyright © 2019 Yassin Mziya. All rights reserved.
//

import UIKit
import SnapKit

class ProgressBarView: UIView {

    var barView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.jeongLightGray
        return view
    }()
    
    var indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.jeongPink
        return view
    }()
    
    var progressLabel: UILabel = {
        let label = UILabel()
        label.text = "24%"
        label.textColor = .jeongGray
        label.font = UIFont._12RobotoRegular
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(progressLabel)
        addSubview(barView)
        addSubview(indicatorView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        progressLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.trailing.equalTo(self)
        }
        
        barView.snp.makeConstraints { make in
            make.trailing.equalTo(progressLabel.snp.leading).offset(-8)
            make.centerY.leading.equalTo(self)
            make.height.equalTo(2)
        }
        
        indicatorView.snp.makeConstraints { make in
            make.leading.top.bottom.equalTo(barView)
            make.trailing.equalTo(barView).offset(-50)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
