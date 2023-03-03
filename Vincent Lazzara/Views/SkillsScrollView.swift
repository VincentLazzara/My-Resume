//
//  ScrollView.swift
//  Vincent Lazzara
//
//  Created by Vinny Lazzara on 3/3/23.
//

import UIKit

class SkillsView: UIScrollView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let labels = ["Analytical\nThinking", "Excellent\nProblem\nSolving", "Highly\nAdaptable", "Persistent", "Hard\nWorking", "Great\nCommunicator","Resourceful", "Reliable"]
        
        let size = labels.count * 155
        
        contentSize = CGSize(width: size, height: 100)

        let labelsView = UIView()
        labelsView.setDimensions(width: CGFloat(size), height: 100)
        addSubview(labelsView)

        let labelWidth = 150
        let labelHeight = 75
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
