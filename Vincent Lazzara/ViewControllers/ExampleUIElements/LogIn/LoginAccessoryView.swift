//
//  LoginAccessoryView.swift
//  Vincent Lazzara
//
//  Created by Vinny Lazzara on 3/13/23.
//

import UIKit

class LoginAccessoryView: UIView{

    
    var textLabel: UITextField = {
        let tf = UITextField()
        tf.text = ""
        tf.textAlignment = .left
        tf.font = UIFont(name: "AvenirNext-Medium", size: 16)
        tf.textColor = .black
        tf.isUserInteractionEnabled = false
        tf.contentMode = .scaleAspectFit
        return tf
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
        textLabel.anchor(left: emailLabel.rightAnchor, paddingLeft: 10)
        textLabel.centerY(inView: self)
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
        
        layer.cornerRadius = 16
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        
    }
    
    override var intrinsicContentSize: CGSize{
        return .zero
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeFont(labelFont: UIFont, textFont: UIFont){
        textLabel.font = textFont
        emailLabel.font = labelFont
        
    }

}
