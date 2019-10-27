//
//  GroupsCollectionViewCell.swift
//  jeong.do
//
//  Created by Yassin Mziya on 6/3/19.
//  Copyright © 2019 Yassin Mziya. All rights reserved.
//

import UIKit
import SnapKit

class GroupsCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "GroupsCollectionViewCell"
    
    var glyphImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.backgroundColor = .lightGray
        imgView.layer.cornerRadius = 24
        imgView.clipsToBounds = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.attributedText = metadata
        
        return label
    }()
    
    var progressBarView: ProgressBarView = {
        let progBar = ProgressBarView()
        progBar.translatesAutoresizingMaskIntoConstraints = false
        return progBar
    }()
    
    var glyphTopAnchor: NSLayoutConstraint!
    var glyphLeadingAnchor: NSLayoutConstraint!
    var metadataLabelTopAnchor: NSLayoutConstraint!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 16
        
        addSubview(glyphImageView)
        glyphTopAnchor = glyphImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24)
        glyphLeadingAnchor = glyphImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24)
        
        addSubview(metadataLabel)
        metadataLabelTopAnchor = metadataLabel.topAnchor.constraint(equalTo: centerYAnchor, constant: 64)
        
        addSubview(progressBarView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        glyphImageView.snp.makeConstraints { make in
//            make.top.leading.equalToSuperview().offset(24)
//            make.height.width.equalTo(48)
//        }
//
//        metadataLabel.snp.makeConstraints { make in
//            make.leading.equalTo(glyphImageView)
//            make.top.equalTo(self.snp.centerY).offset(64)
//        }
//
//        progressBarView.snp.makeConstraints { make in
//            make.leading.equalTo(metadataLabel)
//            make.centerX.equalToSuperview()
//            make.top.equalTo(metadataLabel.snp.bottom).offset(16)
//            make.height.equalTo(24)
//        }
        
        NSLayoutConstraint.activate([
            glyphTopAnchor,
            glyphLeadingAnchor,
            glyphImageView.heightAnchor.constraint(equalToConstant: 48),
            glyphImageView.widthAnchor.constraint(equalToConstant: 48),
            ])
        
        NSLayoutConstraint.activate([
            metadataLabel.leadingAnchor.constraint(equalTo: glyphImageView.leadingAnchor),
            metadataLabelTopAnchor
            ])
        
        NSLayoutConstraint.activate([
            progressBarView.leadingAnchor.constraint(equalTo: metadataLabel.leadingAnchor),
            progressBarView.centerXAnchor.constraint(equalTo: centerXAnchor),
            progressBarView.topAnchor.constraint(equalTo: metadataLabel.bottomAnchor, constant: 16),
            progressBarView.heightAnchor.constraint(equalToConstant: 24)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func grow(in targetView: UIView, cv: UICollectionView) {
        // TODO: init new view to animate and hide cell
        let startingFrame = targetView.convert(self.frame, from: cv)
        let animatingView = GroupsCollectionViewCell(frame: startingFrame)
        targetView.addSubview(animatingView)
        self.alpha = 0
        
        // TODO: grow animation
        animatingView.glyphLeadingAnchor.constant = 55
        animatingView.glyphTopAnchor.constant = 90
        animatingView.metadataLabelTopAnchor.constant = 10
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: .curveEaseIn,
            animations: {
                animatingView.frame = targetView.frame
                animatingView.layoutIfNeeded()
        }, completion: nil)
        
        
    }

}
