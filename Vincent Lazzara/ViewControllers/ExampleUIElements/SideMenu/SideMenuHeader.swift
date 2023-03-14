//
//  SideMenuHeader.swift
//  Vincent Lazzara
//
//  Created by Vinny Lazzara on 3/13/23.
//

import UIKit

class SideMenuHeader: UIView {
    
    //MARK: Properties
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 24)
        label.text = "Your Name"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let icon: UIImageView = {
        let icon = UIImageView(image: UIImage(named: "profileIcon")?.withTintColor(.white))
        icon.setDimensions(width: 38, height: 38)
        return icon
    }()
    
    
    //MARK: Lifecycle
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(icon)
        icon.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 20)
        
        addSubview(nameLabel)
        nameLabel.centerY(inView: icon, leftAnchor: icon.rightAnchor, paddingLeft: 20)
        
        let dividerView = UIView()
        dividerView.setDimensions(width: self.frame.width, height: 2)
        dividerView.backgroundColor = .white
        addSubview(dividerView)
        //dividerView.centerX(inView: self)
        dividerView.anchor(bottom: bottomAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
