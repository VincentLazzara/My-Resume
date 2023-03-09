//
//  HeaderView.swift
//  Vincent Lazzara
//
//  Created by Vinny Lazzara on 3/2/23.
//

import UIKit

protocol customNavBarDelegate: class{
    func linkPressed()
}

class CustomNavigationBar: UIView {
    
     var delegate: customNavBarDelegate?
    
    public var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Vincent Lazzara"
        label.font = UIFont(name: "CourierNewPS-BoldMT", size: 20)
        label.textAlignment = .center
        label.textColor = .cyan
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "iOS Developer"
        label.font = UIFont(name: "CourierNewPS-BoldMT", size: 18)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "myPhoto.png")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return imageView
    }()
    
    private let background: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    let button: UIButton = {
        let button = UIButton()
        let icon = UIImage(named: "link")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.setImage(icon, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(linkPressed), for: .touchUpInside)
        return button
    }()

    
  
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        backgroundColor = .cyan
        layer.cornerRadius = 20
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        addSubview(background)
        background.anchor(top: topAnchor, left: leftAnchor,  bottom: bottomAnchor, right: rightAnchor, paddingBottom: 5)
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, right: rightAnchor, paddingTop: 5, paddingRight: 15)
        
        addSubview(titleLabel)
        titleLabel.centerX(inView: self, topAnchor: topAnchor, paddingTop: 5)
        
        addSubview(subtitleLabel)
        subtitleLabel.centerX(inView: self, topAnchor: titleLabel.bottomAnchor, paddingTop: 5)
        subtitleLabel.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 5, paddingRight: 5)
        
        addSubview(button)
        button.setDimensions(width: 24, height: 24)
    //   image.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
       // button.centerX(inView: self, topAnchor: topAnchor, paddingTop: 40)
       // bringSubviewToFront(button)
        button.centerY(inView: profileImageView, leftAnchor: leftAnchor, paddingLeft: 27.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func linkPressed(){
        delegate?.linkPressed()
        
    }
    
    
    func configureForTitle(title: String, subtitle: String){
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
        self.profileImageView.isHidden = true
        self.button.isHidden = true
    }
    
}
