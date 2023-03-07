//
//  AppViewController.swift
//  Vincent Lazzara
//
//  Created by Vinny Lazzara on 3/5/23.
//

import UIKit
import CLTypingLabel
import youtube_ios_player_helper
import ImageSlideshow

class AppViewController: UIViewController{
    
    //MARK: Properties
    
    private let scrollView = UIScrollView()
    
    let backLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "CourierNewPS-BoldMT", size: 18)
        label.textColor = .cyan
        label.numberOfLines = 0
        label.text = "< Back"
        label.textAlignment = .left
        label.isUserInteractionEnabled = true
        return label
    }()

    let appsLabel: CLTypingLabel = {
        let label = CLTypingLabel()
        label.font = UIFont(name: "CourierNewPS-BoldMT", size: 20)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    let appTitleText: UILabel = {
         let label = UILabel()
         label.font = UIFont(name: "CourierNewPS-BoldMT", size: 16)
         label.textColor = UIColor(red: 0.8863, green: 0.8863, blue: 0.8863, alpha: 1.0)
         label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
         label.textAlignment = .left
         return label
     }()
    
    
    var app: projectEnumerations? {
        didSet{
            self.appsLabel.text = app?.name
            self.appTitleText.text = app?.description
            self.videoView.load(withVideoId: app?.videoURL ?? "")
            self.featuresText.text = app?.appFeatures
            self.imageScreenshots.setImageInputs(app!.appImages)
            self.appImage.image = app?.appIcon
            
            if app?.buttonLink == "nil"{
                
            }
        }
    }
    
    
    
    let appImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.setDimensions(width: 110, height: 110)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let videoView: YTPlayerView = {
        let view = YTPlayerView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    var inputSource: [InputSource]? {
        didSet{
            self.imageScreenshots.setImageInputs(inputSource!)
        }
    }
    
    let imageScreenshots: ImageSlideshow = {
        let image = ImageSlideshow()
        let pageIndicator = UIPageControl()
        pageIndicator.currentPageIndicatorTintColor = UIColor.lightGray
        pageIndicator.pageIndicatorTintColor = UIColor.black
        image.layer.cornerRadius = 10
        image.layer.borderColor = UIColor.lightGray.cgColor
        image.layer.borderWidth = 2
        image.slideshowInterval = 3
        image.pageIndicator = pageIndicator
        return image
    }()
    
    let featuresLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "CourierNewPS-BoldMT", size: 20)
        label.textColor = .white
        label.numberOfLines = 0
        label.text = "Features:"
        label.textAlignment = .left
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let featuresText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "CourierNewPSMT", size: 16)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        label.isUserInteractionEnabled = true
        return label
    }()
    
    var githubButton: UIButton {
        let button = UIButton(type: .system)
        button.setDimensions(width: 160, height: 30)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 10
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "CourierNewPS-BoldMT", size: 16)
        button.setTitle("View In GitHub", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }
        
    
    //MARK: Lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()
           // view.translatesAutoresizingMaskIntoConstraints = true
          //  view.isUserInteractionEnabled = true
            view.backgroundColor = .black
            navigationController?.navigationBar.barStyle = .black
            tabBarController?.tabBar.barStyle = .black
            navigationController?.navigationBar.isHidden = true
            
            let customNavBar = InvertedHeaderView()
            customNavBar.setDimensions(width: view.frame.width, height: 40)
            view.addSubview(customNavBar)
            customNavBar.centerX(inView: view, topAnchor: view.topAnchor)
            
            view.addSubview(backLabel)
            backLabel.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 18, paddingLeft: 15)
            view.bringSubviewToFront(backLabel)
            
            view.addSubview(scrollView)
            scrollView.setDimensions(width: view.frame.width, height: view.frame.height - 40)
            scrollView.anchor(top: backLabel.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
            
            let contentView = UIView()
            scrollView.addSubview(contentView)
            contentView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addConstraintsToFillView(scrollView)
            contentView.setDimensions(width: scrollView.frame.width, height: 1200)
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    
        
            let backTap = UITapGestureRecognizer(target: self, action: #selector(dismissal))
            backLabel.addGestureRecognizer(backTap)
            
            
            contentView.addSubview(appImage)
            appImage.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, paddingTop: 20, paddingLeft: 20)
            
            var stack = UIStackView()
            
            if app?.buttonLink == "nil"{
                stack = UIStackView(arrangedSubviews: [appsLabel, appTitleText])
            } else {
                stack = UIStackView(arrangedSubviews: [appsLabel, appTitleText, githubButton])
            }
            stack.axis = .vertical
            stack.distribution = .fill
            stack.spacing = 8
            stack.alignment = .leading
            
            contentView.addSubview(stack)
            stack.centerY(inView: appImage, leftAnchor: appImage.rightAnchor, paddingLeft: 20)
            stack.anchor(right: contentView.rightAnchor, paddingRight: 5)
            
            let dividerView = UIView()
            dividerView.backgroundColor = .gray
            dividerView.setDimensions(width: 400, height: 2)
            
            contentView.addSubview(dividerView)
            dividerView.anchor(top: appImage.bottomAnchor, paddingTop: 25)
            
            contentView.addSubview(videoView)
            videoView.setDimensions(width: view.frame.width / 1.25, height: view.frame.width / 2)
            videoView.centerX(inView: contentView, topAnchor: dividerView.bottomAnchor, paddingTop: 28)
            
           
            contentView.addSubview(imageScreenshots)
            imageScreenshots.setDimensions(width: view.frame.width / 1.25, height: view.frame.height / 1.25)
            imageScreenshots.centerX(inView: contentView, topAnchor: videoView.bottomAnchor, paddingTop: 25)
            
            let featuresStack = UIStackView(arrangedSubviews: [featuresLabel, featuresText])
            featuresStack.axis = .vertical
            featuresStack.distribution = .fillProportionally
            featuresStack.spacing = 0
            
            contentView.addSubview(featuresStack)
            featuresStack.anchor(top: imageScreenshots.bottomAnchor, left: contentView.leftAnchor, paddingTop: 15, paddingLeft: 5)
            contentView.bottomAnchor.constraint(equalTo: featuresStack.bottomAnchor, constant: 60).isActive = true
            
        }
    
    @objc func dismissal(){
        self.dismiss(animated: true)
    }
    
    func updateApp(appTitle: String, appSubtitle: String, appIcon: UIImage, appVideoURL: String, appFeaturesText: String){
        appsLabel.text = appTitle
        appTitleText.text = appSubtitle
        videoView.load(withVideoId: appVideoURL)
        featuresText.text = appFeaturesText
        appImage.image = appIcon
        view.reloadInputViews()
        scrollView.reloadInputViews()
        
    }
    
    @objc func buttonTapped(){
        if let url = URL(string: app!.buttonLink){
            UIApplication.shared.open(url)
        }
    }
    
}


