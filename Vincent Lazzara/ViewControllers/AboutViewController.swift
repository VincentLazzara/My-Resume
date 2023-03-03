//
//  AboutViewController.swift
//  Vincent Lazzara
//
//  Created by Vinny Lazzara on 3/2/23.
//

import UIKit
import CLTypingLabel

class AboutViewController: UIViewController{
    
    //MARK: Properties
    
    private let scrollView = UIScrollView()
    
    private  let careerObjective: CLTypingLabel = {
        let label = CLTypingLabel()
        label.text = "Career Objective:"
        label.font = UIFont(name: "CourierNewPS-BoldMT", size: 16)
        label.textAlignment = .left
        label.textColor = .cyan
        return label
    }()
    
    private let careerText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "CourierNewPSMT", size: 16)
        label.textColor = .white
        label.numberOfLines = 0
        label.text = "With a passion for creating intuitive and user-friendly applications, I have developed a strong foundation in iOS development through various personal projects. I am eager to leverage my skills to contribute to a team of like-minded individuals and continue my growth as a developer in a professional setting."
        label.textAlignment = .left
        return label
    }()

    private  let certificationLabel: CLTypingLabel = {
        let label = CLTypingLabel()
        label.text = "Certifications:"
        label.font = UIFont(name: "CourierNewPS-BoldMT", size: 16)
        label.textAlignment = .left
        label.textColor = .cyan
        return label
    }()
    
    private let certificationText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "CourierNewPSMT", size: 16)
        label.textColor = .white
        label.numberOfLines = 0
        label.text = "• iOS Developer Professional Certificate (Meta) \n \n• Certified Swift User (Apple)\n\n• iOS App Development Bootcamp (London App Brewery) \n\n• Data Structures & Algorithms Bootcamp (Swift Arcade)"
        label.textAlignment = .left
        return label
    }()
    
    private  let technicalSkillsLabel: CLTypingLabel = {
        let label = CLTypingLabel()
        label.text = "Technical Skills (scrollable):"
        label.font = UIFont(name: "CourierNewPS-BoldMT", size: 16)
        label.textAlignment = .left
        label.textColor = .cyan
        return label
    }()
    private let techView = TechScrollView()
    
    private  let personalSkillsLabel: CLTypingLabel = {
        let label = CLTypingLabel()
        label.text = "Personal Skills (scrollable):"
        label.font = UIFont(name: "CourierNewPS-BoldMT", size: 16)
        label.textAlignment = .left
        label.textColor = .cyan
        return label
    }()
    
    private let skillView = SkillsView()
    
    private  let educationLabel: CLTypingLabel = {
        let label = CLTypingLabel()
        label.text = "Education:"
        label.font = UIFont(name: "CourierNewPS-BoldMT", size: 16)
        label.textAlignment = .left
        label.textColor = .cyan
        return label
    }()
    
    private let educationText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "CourierNewPSMT", size: 16)
        label.textColor = .white
        label.numberOfLines = 0
        label.text = "B.A. Business Administration - Finance Concenctration \nCalifornia State University, Fullerton \n (April 2023)"
        label.textAlignment = .left
        return label
    }()
    
    private  let aboutLabel: CLTypingLabel = {
        let label = CLTypingLabel()
        label.text = "About Me:"
        label.font = UIFont(name: "CourierNewPS-BoldMT", size: 16)
        label.textAlignment = .left
        label.textColor = .cyan
        return label
    }()
    
    private let aboutMeText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "CourierNewPSMT", size: 16)
        label.textColor = .white
        label.numberOfLines = 0
        label.text = "• I love 70s rock! \n \n• I collect cassettes & records \n \n• I enjoy fixing old cars \n \n• I'm always learning something new! \n \n• I volunteer as a tutor for JOYA scholars \n \n• I was a boxer in my teens"
        label.textAlignment = .left
        return label
    }()
    
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        view.backgroundColor = .black
         navigationController?.navigationBar.barStyle = .black
         tabBarController?.tabBar.barStyle = .black
        configure()
        
    }
    
    func configure(){
        let customNavBar = CustomNavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 70))
        navigationController?.navigationBar.addSubview(customNavBar)
        
        view.addSubview(scrollView)
        scrollView.addConstraintsToFillView(view)
        
        let contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        contentView.addSubview(careerObjective)
        careerObjective.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, paddingTop: 60, paddingLeft: 10)
        
        contentView.addSubview(careerText)
        careerText.centerX(inView: contentView, topAnchor: careerObjective.bottomAnchor, paddingTop: 5)
        careerText.anchor(left: contentView.leftAnchor, right: contentView.rightAnchor, paddingLeft: 15, paddingRight: 10)
        
        
        
        contentView.addSubview(certificationLabel)
        certificationLabel.anchor(top: careerText.bottomAnchor, left: contentView.leftAnchor, paddingTop: 25, paddingLeft: 10)
        
        contentView.addSubview(certificationText)
        certificationText.anchor(top: certificationLabel.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 5, paddingLeft: 15, paddingRight: 5)
        
        
        contentView.addSubview(technicalSkillsLabel)
        technicalSkillsLabel.anchor(top: certificationText.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 25, paddingLeft: 10, paddingRight: 5)
        
        
        techView.setDimensions(width: view.frame.width, height: 100)
        contentView.addSubview(techView)
        techView.centerX(inView: view, topAnchor: certificationText.bottomAnchor, paddingTop: 25)
        
        contentView.addSubview(personalSkillsLabel)
        personalSkillsLabel.anchor(top: techView.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 25, paddingLeft: 10, paddingRight: 5)
        
        
        skillView.setDimensions(width: view.frame.width, height: 100)
        contentView.addSubview(skillView)
        skillView.centerX(inView: view, topAnchor: personalSkillsLabel.bottomAnchor)
        
        
        contentView.addSubview(educationLabel)
            
        educationLabel.anchor(top: skillView.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 25, paddingLeft: 10, paddingRight: 10)
        
        contentView.addSubview(educationText)
        educationText.anchor(top: educationLabel.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 5, paddingLeft: 15, paddingRight: 5)
        
        contentView.addSubview(aboutLabel)
            
        aboutLabel.anchor(top: educationText.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 25, paddingLeft: 10, paddingRight: 10)
        
        contentView.addSubview(aboutMeText)
        aboutMeText.anchor(top: aboutLabel.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 5, paddingLeft: 15, paddingRight: 5)
        
        
        
        contentView.bottomAnchor.constraint(equalTo: aboutMeText.bottomAnchor, constant: 50).isActive = true
        
    }
    
}
