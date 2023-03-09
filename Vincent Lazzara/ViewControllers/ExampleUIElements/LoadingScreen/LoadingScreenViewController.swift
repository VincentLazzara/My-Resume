//
//  LoadingScreenViewController.swift
//  Vincent Lazzara
//
//  Created by Vinny Lazzara on 3/9/23.
//

import UIKit
import Lottie


class LoadingViewController: UIViewController{
    
    //MARK: Properties
    
    lazy var av1 = createAnimation(named: "an1")
    lazy var av2 = createAnimation(named: "an2")
    lazy var av3 = createAnimation(named: "an5")
    lazy var av4 = createAnimation(named: "an4")
    lazy var av5 = createAnimation(named: "an3")
    lazy var av6 = createAnimation(named: "an8")
    lazy var av8 = createAnimation(named: "an7")
    lazy var av7 = createAnimation(named: "an6")
    
    private let continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue", for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel!.font = UIFont(name: "CourierNewPSMT", size: 20)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.setDimensions(width: 120, height: 45)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    private let loadingLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading Examples:"
        label.font = UIFont(name: "CourierNewPS-BoldMT", size: 24)
        label.textColor = .black
        return label
    }()
    
    
    
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        configure()
    }
    
    
    func configure(){

        let leftStack = UIStackView(arrangedSubviews: [av1, av2, av3, av7])
        leftStack.axis = .vertical
        view.backgroundColor = .white
        
        let rightStack = UIStackView(arrangedSubviews: [av4, av5, av6, av8])
        rightStack.axis = .vertical
        
        let stack = UIStackView(arrangedSubviews: [leftStack, rightStack])
        stack.axis = .horizontal
        
        view.addSubview(loadingLabel)
        loadingLabel.centerX(inView: view, topAnchor: view.topAnchor, paddingTop: 15)
        
        view.addSubview(stack)
        stack.centerX(inView: view, topAnchor: loadingLabel.bottomAnchor, paddingTop: 15)
        
        view.addSubview(continueButton)
        continueButton.centerX(inView: view, topAnchor: stack.bottomAnchor, paddingTop: 15)
   
        
        
    }
    
}

extension LoadingViewController{
    
    
    
    @objc func buttonPressed(){
        self.dismiss(animated: true)
    }
    
    func createAnimation(named: String) -> LottieAnimationView{
        
        let animation: LottieAnimationView?
        animation = .init(name: named)
        animation?.contentMode = .scaleAspectFit
        animation?.loopMode = .loop
        animation?.animationSpeed = 0.6
        animation?.setDimensions(width: 125, height: 125)
        animation?.play()
        return animation!
    }
}
