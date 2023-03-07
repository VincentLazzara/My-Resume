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
    
    private var backgroundSheetLauncher: LinkSheetLauncher!
    
    private let scrollView = UIScrollView()
    
    private let viewModel = AboutViewModel()
    
    private lazy var careerObjective = viewModel.careerObjective
    private lazy var careerText = viewModel.careerText

    private lazy var certificationLabel = viewModel.certificationLabel
    private lazy var certificationText =  viewModel.certificationText
    
    private lazy var technicalSkillsLabel = viewModel.technicalSkillsLabel
    private lazy var techView = viewModel.techView
    
    private  lazy var personalSkillsLabel = viewModel.personalSkillsLabel
    private lazy var skillView = viewModel.skillView
    
    private lazy var educationLabel = viewModel.educationLabel
    private lazy var educationText = viewModel.educationText
    
    private lazy var aboutLabel = viewModel.aboutLabel
    private lazy var aboutMeText = viewModel.aboutMeText
    
    
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
        customNavBar.delegate = self
        
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


extension AboutViewController: customNavBarDelegate{
    func linkPressed() {
        self.backgroundSheetLauncher = LinkSheetLauncher()
        self.backgroundSheetLauncher.delegate = self
        self.backgroundSheetLauncher.show()
    }
    
    
    
}

//MARK: Background Sheet Delegate
extension AboutViewController: LinkSheetLauncherDelegate{
    func didSelect(option: LinkActionOptions) {
        UIApplication.shared.open(option.url)
    }
}
