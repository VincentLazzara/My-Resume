//
//  AboutViewModel.swift
//  Vincent Lazzara
//
//  Created by Vinny Lazzara on 3/3/23.
//

import UIKit
import CLTypingLabel


class AboutViewModel{
    
    
    public let careerObjective: CLTypingLabel = {
        let label = CLTypingLabel()
        label.text = "Career Objective:"
        label.font = UIFont(name: "CourierNewPS-BoldMT", size: 16)
        label.textAlignment = .left
        label.textColor = .cyan
        return label
    }()
    
    public let careerText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "CourierNewPSMT", size: 16)
        label.textColor = .white
        label.numberOfLines = 0
        label.text = "With a passion for creating intuitive and user-friendly applications, I have developed a strong foundation in iOS development through various personal projects. I am eager to leverage my skills to contribute to a team of like-minded individuals and continue my growth as a developer in a professional setting."
        label.textAlignment = .left
        return label
    }()

    public  let certificationLabel: CLTypingLabel = {
        let label = CLTypingLabel()
        label.text = "Certifications:"
        label.font = UIFont(name: "CourierNewPS-BoldMT", size: 16)
        label.textAlignment = .left
        label.textColor = .cyan
        return label
    }()
    
    public let certificationText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "CourierNewPSMT", size: 16)
        label.textColor = .white
        label.numberOfLines = 0
        label.text = "• iOS Developer Professional Certificate (Meta) \n \n• Certified Swift User (Apple)\n\n• iOS App Development Bootcamp (London App Brewery) \n\n• Data Structures & Algorithms Bootcamp (Swift Arcade)"
        label.textAlignment = .left
        return label
    }()
    
    public  let technicalSkillsLabel: CLTypingLabel = {
        let label = CLTypingLabel()
        label.text = "Technical Skills (scrollable):"
        label.font = UIFont(name: "CourierNewPS-BoldMT", size: 16)
        label.textAlignment = .left
        label.textColor = .cyan
        return label
    }()
    public let techView = TechScrollView()
    
    public  let personalSkillsLabel: CLTypingLabel = {
        let label = CLTypingLabel()
        label.text = "Personal Skills (scrollable):"
        label.font = UIFont(name: "CourierNewPS-BoldMT", size: 16)
        label.textAlignment = .left
        label.textColor = .cyan
        return label
    }()
    
    public let skillView = SkillsView()
    
    public  let educationLabel: CLTypingLabel = {
        let label = CLTypingLabel()
        label.text = "Education:"
        label.font = UIFont(name: "CourierNewPS-BoldMT", size: 16)
        label.textAlignment = .left
        label.textColor = .cyan
        return label
    }()
    
    public let educationText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "CourierNewPSMT", size: 16)
        label.textColor = .white
        label.numberOfLines = 0
        label.text = "B.A. Business Administration - Finance Concenctration \nCalifornia State University, Fullerton"
        label.textAlignment = .left
        return label
    }()
    
    public  let aboutLabel: CLTypingLabel = {
        let label = CLTypingLabel()
        label.text = "About Me:"
        label.font = UIFont(name: "CourierNewPS-BoldMT", size: 16)
        label.textAlignment = .left
        label.textColor = .cyan
        return label
    }()
    
    public let aboutMeText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "CourierNewPSMT", size: 16)
        label.textColor = .white
        label.numberOfLines = 0
        label.text = "• I love 70s rock! \n \n• I collect cassettes & records \n \n• I watch Swift streamers for fun\n \n• I enjoy fixing old cars \n \n• I'm always learning something new! \n \n• I volunteer as a tutor for JOYA scholars \n \n• I was a boxer in my teens"
        label.textAlignment = .left
        return label
    }()
    
    
    
}


