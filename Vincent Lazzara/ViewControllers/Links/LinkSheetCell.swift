//
//  LinkSheetCell.swift
//  Vincent Lazzara
//
//  Created by Vinny Lazzara on 3/7/23.
//

import UIKit


class LinkSheetCell: UITableViewCell{
    
    //MARK: Properties
    
    var option: LinkActionOptions?{
        didSet{ configure()
        }
    }
    
    private let optionImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "github.png")
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "CourierNewPSMT", size: 22)
        label.textColor = .darkGray
        return label
    }()
    
    
    
    //MARK: Lifecycle
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(optionImageView)
        optionImageView.centerY(inView: self)
        optionImageView.anchor(left: leftAnchor, paddingLeft: 8)
        optionImageView.setDimensions(width: 28, height: 28)
        
        addSubview(titleLabel)
        titleLabel.centerY(inView: self)
        titleLabel.anchor(left: optionImageView.rightAnchor, paddingLeft: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        titleLabel.text = option?.title
        optionImageView.image = option?.image
    }
}




