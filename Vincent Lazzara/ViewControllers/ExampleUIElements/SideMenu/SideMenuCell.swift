//
//  SideMenuCell.swift
//  Vincent Lazzara
//
//  Created by Vinny Lazzara on 3/13/23.
//

import UIKit


struct SideMenuItem {
    let name: String
    let icon: String
    let notifications: Int
}



class SideMenuCell: UITableViewCell{
    
    //MARK: Properties
    
    private let icon: UIImageView = {
        let icon = UIImageView()
        icon.setDimensions(width: 20, height: 20)
        return icon
    }()
    
    
   private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        label.text = "Dashboard"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    
    private let notificationLabel: UIButton = {
        let button = UIButton(type: .system)
       // button.setDimensions(width: 35, height: 25)
        button.sizeToFit()
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        button.backgroundColor = .white
        button.setTitle("10", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    var menu: SideMenuItem?{
        didSet{
            self.icon.image = UIImage(named: menu?.icon ?? "")?.withTintColor(.white)
            self.nameLabel.text = menu?.name
            if menu?.notifications == 0 {
                self.notificationLabel.isHidden = true
            } else {
                self.notificationLabel.setTitle("\(menu?.notifications ?? 0)", for: .normal)
            }
            
        }
    }
    
    //MARK: Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        addSubview(icon)
        icon.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 15)
        
        addSubview(nameLabel)
        nameLabel.centerY(inView: icon, leftAnchor: icon.rightAnchor, paddingLeft: 15)
        
        addSubview(notificationLabel)
        notificationLabel.centerY(inView: nameLabel)
        notificationLabel.anchor(right: rightAnchor, paddingRight: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
