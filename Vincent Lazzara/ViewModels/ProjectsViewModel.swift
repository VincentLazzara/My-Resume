//
//  ProjectsViewModel.swift
//  Vincent Lazzara
//
//  Created by Vinny Lazzara on 3/3/23.
//

import UIKit
import CLTypingLabel

class ProjectsViewModel{
    
    let allAppsLabel: CLTypingLabel = {
        let label = CLTypingLabel()
        label.text = "All Apps"
        label.font = UIFont(name: "CourierNewPS-BoldMT", size: 20)
        label.textAlignment = .left
        label.textColor = .cyan
        label.pauseTyping()
        return label
    }()
    
    
    let appsLabel: CLTypingLabel = {
        let label = CLTypingLabel()
        label.text = "RESTful API"
        label.font = UIFont(name: "CourierNewPS-BoldMT", size: 20)
        label.textAlignment = .left
        label.textColor = .cyan
        label.pauseTyping()
        return label
    }()
    
    
   let appTitleText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "CourierNewPS-BoldMT", size: 16)
        label.textColor = .white
        label.numberOfLines = 0
        label.text = "The SLAP"
        label.textAlignment = .left
        return label
    }()
    
    let appSubtitleText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "CourierNewPSMT", size: 14)
        label.textColor = .white
        label.numberOfLines = 0
        label.text = "What's hot @ Hollywood Arts"
        label.textAlignment = .left
        return label
    }()
    
}

