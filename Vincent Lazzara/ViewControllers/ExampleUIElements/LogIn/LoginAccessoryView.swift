//
//  LoginAccessoryView.swift
//  Vincent Lazzara
//
//  Created by Vinny Lazzara on 3/13/23.
//

import UIKit

class LoginAccessoryView: UIView{

    
    var textLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        label.textColor = .black
        return label
    }()
    var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email:"
        label.font = UIFont(name: "AvenirNext-Bold", size: 16)
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(emailLabel)
        emailLabel.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 15)
        addSubview(textLabel)
        textLabel.centerY(inView: self, leftAnchor: emailLabel.rightAnchor, paddingLeft: 10)
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
        
        layer.cornerRadius = 16
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
