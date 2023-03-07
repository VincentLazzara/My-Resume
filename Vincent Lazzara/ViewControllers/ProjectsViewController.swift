//
//  ProjectsViewController.swift
//  Vincent Lazzara
//
//  Created by Vinny Lazzara on 3/2/23.
//

import CLTypingLabel
import UIKit

class ProjectsViewController: UIViewController{
    
    //MARK: Properties
    
    let viewModel = ProjectsViewModel()
    
    let appViewModel = AppViewModel()
    
    lazy var allAppsLabel = viewModel.allAppsLabel
    
    lazy var apiLabel = viewModel.allAppsLabel
    
    private let scrollView = UIScrollView()
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        view.backgroundColor = .black
        navigationController?.navigationBar.barStyle = .black
        tabBarController?.tabBar.barStyle = .black
        //navigationController?.navigationBar.isHidden = true
        
        let customNavBar = CustomNavigationBar()
        customNavBar.setDimensions(width: view.frame.width, height: 80)
        customNavBar.configureForTitle(title: "Projects", subtitle: "My Projects")
        navigationController?.navigationBar.addSubview(customNavBar)
        
        view.addSubview(scrollView)
        scrollView.addConstraintsToFillView(view)
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor)
        
        let contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraintsToFillView(scrollView)
       // contentView.setDimensions(width: view.frame.width, height: 1000)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
       
       
        contentView.addSubview(allAppsLabel)
        allAppsLabel.anchor(top: contentView.topAnchor, left: view.leftAnchor, paddingTop: 75, paddingLeft: 10)
        
        let scrollView = AppScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.setDimensions(width: view.frame.width, height: 150)
        scrollView.appDelegate = self
        contentView.addSubview(scrollView)
        scrollView.centerX(inView: contentView, topAnchor: allAppsLabel.bottomAnchor, paddingTop: 25)
        
        let dividerView = UIView()
        dividerView.setDimensions(width: view.frame.width, height: 2)
        dividerView.backgroundColor = .lightGray
        contentView.addSubview(dividerView)
        dividerView.centerX(inView: contentView, topAnchor: scrollView.bottomAnchor, paddingTop: 2)
        
        
        let blackScholes = createAppStack(app: .blackScholes, category: "API", isLeft: false)
        
        contentView.addSubview(blackScholes)
        blackScholes.anchor(top: dividerView.bottomAnchor, left: view.leftAnchor, paddingTop: 25, paddingLeft: 25)
        blackScholes.setDimensions(width: (view.frame.width / 2) - 25, height: 150)
        
        let imageViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(blackScholesTapped))
        blackScholes.addGestureRecognizer(imageViewTapGesture)
        
        let theSLAP = createAppStack(app: .theSLAP, category: "Firebase", isLeft: true)
        
        contentView.addSubview(theSLAP)
        theSLAP.anchor(top: dividerView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 25, paddingRight: 25)
        theSLAP.setDimensions(width: (view.frame.width / 2) - 25, height: 150)
        let slapTapGesture = UITapGestureRecognizer(target: self, action: #selector(theSlapTapped))
        theSLAP.addGestureRecognizer(slapTapGesture)
        
        
        let todoie = createAppStack(app: .todoie, category: "Local Data", isLeft: false)
        
        contentView.addSubview(todoie)
        todoie.anchor(top:blackScholes.bottomAnchor, left: contentView.leftAnchor, paddingTop: 35, paddingLeft: 25)
        todoie.setDimensions(width: (view.frame.width / 2) - 25, height: 150)
        
        let todoTapGesture = UITapGestureRecognizer(target: self, action: #selector(todoieTapped))
        todoie.addGestureRecognizer(todoTapGesture)
        
        let seefood = createAppStack(app: .seeFood, category: "CoreML", isLeft: true)
        
        contentView.addSubview(seefood)
        seefood.anchor(top: theSLAP.bottomAnchor, right: contentView.rightAnchor, paddingTop: 35, paddingRight: 25)
        seefood.setDimensions(width: (view.frame.width / 2) - 25, height: 150)
        
        let seefoodTap = UITapGestureRecognizer(target: self, action: #selector(seefoodTapped))
        seefood.addGestureRecognizer(seefoodTap)
        
        contentView.bottomAnchor.constraint(equalTo: todoie.bottomAnchor, constant: 60).isActive = true
        
    }
    
    @objc func blackScholesTapped() {
        let nav = AppViewController()
        nav.app = .blackScholes
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
        
    }
    @objc func theSlapTapped() {
        let nav = AppViewController()
        nav.app = .theSLAP
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
        
    }
    @objc func todoieTapped() {
        let nav = AppViewController()
        nav.app = .todoie
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
        
    }
    @objc func seefoodTapped() {
        let nav = AppViewController()
        nav.app = .seeFood
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        allAppsLabel.continueTyping()
    }
    
}

extension ProjectsViewController: AppScrollViewDelegate{
    func userDidSelect(app: String) {
        print(app)
    }
    
    
    
    
}

//MARK: UI Functions

extension ProjectsViewController{
    
    func createAppStack(app: projectEnumerations, category: String, isLeft: Bool) -> UIStackView{
        
        let categoryLabel: CLTypingLabel = {
            let label = CLTypingLabel()
            label.text = category
            label.font = UIFont(name: "CourierNewPS-BoldMT", size: 20)
            label.textAlignment = isLeft ? .left : .right
            label.textColor = .cyan
            return label
        }()
        
       let appTitleLabel: UILabel = {
             let label = UILabel()
             label.font = UIFont(name: "CourierNewPS-BoldMT", size: 16)
             label.textColor = .white
           label.textAlignment = isLeft ? .left : .right
             label.numberOfLines = 0
           label.text = app.name
             return label
         }()
       
        
        let appSubtitleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "CourierNewPSMT", size: 14)
            label.textColor = .white
            label.numberOfLines = 0
            label.textAlignment = isLeft ? .right : .left
            label.text =  app.description
            return label
        }()

       
        let imageView = UIImageView(image: app.appIcon)
       imageView.contentMode = .scaleAspectFit
       imageView.layer.borderWidth = 2
       imageView.layer.borderColor = UIColor.lightGray.cgColor
       imageView.clipsToBounds = true
       imageView.layer.cornerRadius = 8
       imageView.setDimensions(width: 50, height: 50)
       imageView.translatesAutoresizingMaskIntoConstraints = false
       
       let stackView = UIStackView(arrangedSubviews: [categoryLabel, imageView, appTitleLabel, appSubtitleLabel])
       stackView.axis = .vertical
       stackView.spacing = 4
       if isLeft{
           stackView.alignment = .trailing
       } else{
           stackView.alignment = .leading
       }
       return stackView
       
   }

}



