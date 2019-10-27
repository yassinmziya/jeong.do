//
//  HomeViewController.swift
//  jeong.do
//
//  Created by Yassin Mziya on 6/3/19.
//  Copyright © 2019 Yassin Mziya. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    var colors: [[CGColor]] = [
        [UIColor.jeongOrange.cgColor, UIColor.jeongPink.cgColor],
        [UIColor.jeongBlue.cgColor, UIColor.jeongPurple.cgColor],
        [UIColor.jeongPink.cgColor, UIColor.jeongPurple.cgColor],
        [UIColor.jeongOrange.cgColor, UIColor.jeongBlue.cgColor],
        [UIColor.jeongBlue.cgColor, UIColor.jeongOrange.cgColor],
    ]
    
    var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.frame = UIScreen.main.bounds
        layer.startPoint = CGPoint(x: 1, y: 0)
        layer.endPoint = CGPoint(x: 0, y: 1)
        return layer
    }()
    
    var profileImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.backgroundColor = .lightGray
        imgView.layer.cornerRadius = 24
        imgView.clipsToBounds = true
        return imgView
    }()
    
    var welcomeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        label.textColor = .white
        
        let msg = NSMutableAttributedString(string: "Hello, Jane.", attributes: [
            NSAttributedString.Key.font : UIFont._36RobotoRegular!,
            ])
        
        let subMsg = NSMutableAttributedString(string: "\n\nLooks like feel good.\nYou have 3 tasks to do today.", attributes: [
            NSAttributedString.Key.font : UIFont._16RobotoLight!,
            ])
        
        msg.append(subMsg)
        label.attributedText = msg
        return label
    }()
    
    var dateLabel: UILabel = {
       let label = UILabel()
        label.text = "TODAY: JUNE 3, 2019"
        label.font = UIFont._12Ramabhadra
        label.textColor = .white
        return label
    }()
    
    var groupsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 55, bottom: 0, right: 55)
        layout.minimumLineSpacing = 24
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    var currentIndex = 0 {
        didSet {
            changeBackground(index: currentIndex)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientLayer.colors = colors[currentIndex]
        view.layer.addSublayer(gradientLayer)
        
        view.addSubview(profileImageView)
        view.addSubview(welcomeLabel)
        view.addSubview(dateLabel)
        view.addSubview(groupsCollectionView)
        groupsCollectionView.delegate = self
        groupsCollectionView.dataSource = self
        groupsCollectionView.register(GroupsCollectionViewCell.self, forCellWithReuseIdentifier: GroupsCollectionViewCell.reuseId)
        
        setupConstraints()
//        for family in UIFont.familyNames.sorted() {
//            let names = UIFont.fontNames(forFamilyName: family)
//            print("Family: \(family) Font names: \(names)")
//        }
    }
    
    func setupConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30 + 50)
            make.leading.equalTo(55)
            make.height.width.equalTo(48)
        }
        
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(22)
            make.leading.equalTo(profileImageView)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(48)
            make.leading.equalTo(welcomeLabel)
        }
        
        groupsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(9)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(400)
        }
    }
    
}

// MARK:
extension HomeViewController: UICollectionViewDelegate, UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let layout = groupsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = 290 + layout.minimumLineSpacing
        
        let offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left)/cellWidthIncludingSpacing
        let roundIndex = round(index)
        self.currentIndex = Int(roundIndex)
        print(roundIndex)
        
        let finalOffset = CGPoint(x: roundIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
        targetContentOffset.pointee = finalOffset
        
    }
    
}

// MARK:- UICollectionViewDataSource 
extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = groupsCollectionView.dequeueReusableCell(withReuseIdentifier: GroupsCollectionViewCell.reuseId, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = groupsCollectionView.dequeueReusableCell(withReuseIdentifier: GroupsCollectionViewCell.reuseId, for: indexPath) as! GroupsCollectionViewCell
        navigationController?.pushViewController(GroupViewController(), animated: true)
        // present(GroupViewController(), animated: true, completion: nil)
        // cell.grow(in: view, cv: groupsCollectionView)
    }
    
}

// MARK:- UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 390)
    }
    
}

// MARK:- HELPERS
extension HomeViewController: CAAnimationDelegate {
    
    func changeBackground(index: Int) {
        // Get the current colors of the gradient.
        let oldColors = gradientLayer.colors
        
        // Define the new colors for the gradient.
        let newColors = colors[index]
        
        // Set the new colors of the gradient.
        gradientLayer.colors = newColors
        
        // Initialize new animation for changing the colors of the gradient.
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "colors")
        
        // Set current color value.
        animation.fromValue = oldColors
        
        // Set new color value.
        animation.toValue = newColors
        
        // Set duration of animation.
        animation.duration = 0.2
        
        // Set animation to remove once its completed.
        animation.isRemovedOnCompletion = true
        
        // Set receiver to remain visible in its final state when the animation is completed.
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        // Set linear pacing, which causes an animation to occur evenly over its duration.
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        // Set delegate of animation.
        animation.delegate = self
        
        // Add the animation.
        self.gradientLayer.add(animation, forKey: "animateGradientColorChange")
    }
    

}
