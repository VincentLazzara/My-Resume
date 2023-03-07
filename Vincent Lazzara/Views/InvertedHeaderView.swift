//
//  InvertedHeaderView.swift
//  Vincent Lazzara
//
//  Created by Vinny Lazzara on 3/6/23.
//

import UIKit

class InvertedHeaderView: UIView{
    
    private let background: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .cyan
        layer.cornerRadius = 20
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        
        addSubview(background)
        background.anchor(top: topAnchor, left: leftAnchor,  bottom: bottomAnchor, right: rightAnchor, paddingTop: 5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
