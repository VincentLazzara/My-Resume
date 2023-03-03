//
//  ScrollView.swift
//  Vincent Lazzara
//
//  Created by Vinny Lazzara on 3/3/23.
//

import UIKit

class TechScrollView: UIScrollView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let labels = ["Swift", "SwiftUI", "XCode", "CocoaPods", "Firebase", "Local Data\nPersistence", "Realm", "User\nDefaults", "CoreData", "UIKit", "Auto\nLayout","CoreML", "API Calls", "Data\nStructuring", "Git", "JSON\nAPI Calls", "CoreGraphics", "CoreAnimation", "MVM", "MVVM", "Unit\nTesting", "UX\nPrinciples", "UI Design"]
        
        let size = labels.count * 135
        
        contentSize = CGSize(width: size, height: 100)

        let labelsView = UIView()
        labelsView.setDimensions(width: CGFloat(size), height: 100)
        addSubview(labelsView)

        let labelWidth = 130
        let labelHeight = 50
        let labelSpacing = 5


        for i in 0..<labels.count {
            let label = UILabel(frame: CGRect(x: i * (labelWidth + labelSpacing), y: 25, width: labelWidth, height: labelHeight))
            label.text = labels[i]
            label.numberOfLines = 0
            label.textAlignment = .center
            label.font = UIFont(name: "CourierNewPS-BoldMT", size: 16)
            label.textColor = .white
            labelsView.addSubview(label)
        }

        contentInset = UIEdgeInsets(top: 0, left: CGFloat(labelSpacing / 2), bottom: 0, right: CGFloat(labelSpacing / 2))
       contentOffset = CGPoint(x: -labelSpacing / 2, y: 0)

   
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
