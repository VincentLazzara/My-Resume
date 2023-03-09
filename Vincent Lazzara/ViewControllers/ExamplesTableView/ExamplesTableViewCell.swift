//
//  ExamplesTableViewCell.swift
//  Vincent Lazzara
//
//  Created by Vinny Lazzara on 3/7/23.
//

import UIKit
import CLTypingLabel

class ExampleTableViewCell: UITableViewCell{
    
    let titleLabel: CLTypingLabel = {
        let label = CLTypingLabel()
       // label.text = "Onboarding"
        label.font = UIFont(name: "CourierNewPS-BoldMT", size: 20)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .black
        addSubview(titleLabel)
        titleLabel.centerX(inView: self)
        titleLabel.centerY(inView: self)
    
    
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
