//
//  LogInViewController.swift
//  Vincent Lazzara
//
//  Created by Vinny Lazzara on 3/13/23.
//

import Lottie
import UIKit
import MaterialComponents

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties
    
    lazy var highlightedColor = #colorLiteral(red: 0.0941, green: 0.349, blue: 0.8588, alpha: 1) /* #1859db */
    
    var accessoryView: LoginAccessoryView!
    
    var isPasswordHidden = true
    
    private let av: LottieAnimationView = {
        let animation: LottieAnimationView?
        animation = .init(name: "login")
        animation?.contentMode = .scaleAspectFit
        animation?.loopMode = .loop
        animation?.animationSpeed = 0.6
        animation?.setDimensions(width: 250, height: 250)
        animation?.isHidden = true
        animation?.play()
        return animation!
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome Back."
        label.font = UIFont(name: "BodoniSvtyTwoITCTT-Bold", size: 34)
        label.textColor = .white
        return label
    }()
    
    let emailInput: MDCOutlinedTextField = {
        let tf = MDCOutlinedTextField(frame: CGRect(x: 0, y: 0, width: 250, height: 30))
        tf.placeholder = "Enter Your Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.label.text = "Email"
        tf.font = UIFont(name: "AvenirNext-Medium", size: 16)
        tf.setFloatingLabelColor(UIColor(hue: 0.6111, saturation: 0.89, brightness: 0.85, alpha: 1.0), for: .editing)
        tf.setOutlineColor(UIColor(hue: 0.6111, saturation: 0.89, brightness: 0.85, alpha: 1.0), for: .editing)
        tf.sizeToFit()
        tf.preferredContainerHeight = 20
        tf.verticalDensity = 2
        tf.textAlignment = .left
        tf.isHidden = true
        
        //Trying to disable predictive bar
        tf.inputAssistantItem.leadingBarButtonGroups = []
        tf.inputAssistantItem.trailingBarButtonGroups = []
        tf.keyboardType = .emailAddress
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        return tf
    }()
    
    
    let passwordInput: MDCOutlinedTextField = {
        let tf = MDCOutlinedTextField(frame: CGRect(x: 0, y: 0, width: 250, height: 30))
        tf.placeholder = "Enter Your Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.label.text = "Password"
        tf.font = UIFont(name: "AvenirNext-Medium", size: 16)
        tf.setFloatingLabelColor(UIColor(hue: 0.6111, saturation: 0.89, brightness: 0.85, alpha: 1.0), for: .editing)
        tf.setOutlineColor(UIColor(hue: 0.6111, saturation: 0.89, brightness: 0.85, alpha: 1.0), for: .editing)
        tf.sizeToFit()
        tf.preferredContainerHeight = 20
        tf.verticalDensity = 2
        tf.textAlignment = .left
        tf.isHidden = true
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let passwordIcon: UIImageView = {
        let image = UIImageView(image: UIImage(named: "hide"))
        image.setDimensions(width: 26, height: 26)
        image.isUserInteractionEnabled = true
        image.isHidden = true
        return image
    }()
    
    
    private let forgotPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Forgot Password?"
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        label.textColor = #colorLiteral(red: 0.0941, green: 0.349, blue: 0.8588, alpha: 1)
        label.isHidden = true
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setDimensions(width: 200, height: 35)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        button.backgroundColor = #colorLiteral(red: 0.0941, green: 0.349, blue: 0.8588, alpha: 1)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.isHidden = true
        return button
    }()
    
    
    private let orLoginWithLabel: UILabel = {
        let label = UILabel()
        label.text = "Or continue with"
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        label.textColor = UIColor.lightGray
        label.isHidden = true
        return label
    }()
    
    lazy var socialStack: UIStackView = {
        let google = createLoginIcon(image: "google")
        let facebook = createLoginIcon(image: "facebook-app-symbol")
        let apple = createLoginIcon(image: "apple")
        let socialStack = UIStackView(arrangedSubviews: [google, facebook, apple])
        socialStack.axis = .horizontal
        socialStack.alignment = .center
        socialStack.isUserInteractionEnabled = true
        socialStack.spacing = 20
        socialStack.isHidden = true
        return socialStack
    }()
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(av)
        av.centerX(inView: view, topAnchor: view.topAnchor, paddingTop: -5)
        
        view.addSubview(welcomeLabel)
        welcomeLabel.centerX(inView: view, topAnchor: av.bottomAnchor)
        
        view.addSubview(emailInput)
        emailInput.centerX(inView: view, topAnchor: welcomeLabel.bottomAnchor, paddingTop: 20)
        emailInput.delegate = self
        
        accessoryView = LoginAccessoryView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 38.5))
        accessoryView.textLabel.text = "Enter text here"
        emailInput.inputAccessoryView = accessoryView
        
        view.addSubview(passwordInput)
        passwordInput.centerX(inView: view, topAnchor: emailInput.bottomAnchor, paddingTop: 10)
        passwordInput.delegate = self
        
        view.addSubview(passwordIcon)
        passwordIcon.centerY(inView: passwordInput, leftAnchor: passwordInput.rightAnchor, paddingLeft: 15)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hidePassword))
        passwordIcon.addGestureRecognizer(tapGesture)
        
        view.addSubview(forgotPasswordLabel)
        forgotPasswordLabel.anchor(top: passwordInput.bottomAnchor, right: passwordInput.rightAnchor, paddingTop: 10)
        
        view.addSubview(loginButton)
        loginButton.centerX(inView: view, topAnchor: forgotPasswordLabel.bottomAnchor, paddingTop: 15)
        loginButton.addTarget(self, action: #selector(didPress), for: .touchUpInside)
        
        view.addSubview(orLoginWithLabel)
        orLoginWithLabel.centerX(inView: view, topAnchor: loginButton.bottomAnchor, paddingTop: 30)
        
        let stackTapGesture = UITapGestureRecognizer(target: self, action: #selector(didPress))
        socialStack.addGestureRecognizer(stackTapGesture)
        
        view.addSubview(socialStack)
        socialStack.centerX(inView: view, topAnchor: orLoginWithLabel.bottomAnchor, paddingTop: 15)
        
        
    }
 
    
    @objc func hidePassword(){
        //User wants password shown
        
        print("Password pressed")
        
        if isPasswordHidden {
            passwordInput.isSecureTextEntry = false
            isPasswordHidden.toggle()
        } else{
            //User wants password hidden
            passwordInput.isSecureTextEntry = true
            isPasswordHidden.toggle()
        }
        
        
    }
    
    @objc func didPress(){
        
        self.dismiss(animated: true)
    }
    
    
    
}

//MARK: Animation Configuration

extension LoginViewController{
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIView.transition(with: welcomeLabel, duration: 1.0, options: .transitionCrossDissolve, animations: { [weak self] in self?.welcomeLabel.textColor = .black}, completion: nil)
        
        UIView.transition(with: av, duration: 1.0, options: .transitionCrossDissolve, animations: { [weak self] in self?.av.isHidden = false}, completion: nil)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            UIView.transition(with: self.emailInput, duration: 1.0, options: .transitionCrossDissolve, animations: { self.emailInput.isHidden = false }, completion: nil)
            
            UIView.transition(with: self.passwordInput, duration: 1.0, options: .transitionCrossDissolve, animations: { self.passwordInput.isHidden = false }, completion: nil)
            
            UIView.transition(with: self.passwordIcon, duration: 1.0, options: .transitionCrossDissolve, animations: { self.passwordIcon.isHidden = false }, completion: nil)
            
            UIView.transition(with: self.forgotPasswordLabel, duration: 1.0, options: .transitionCrossDissolve, animations: { self.forgotPasswordLabel.isHidden = false }, completion: nil)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            UIView.transition(with: self.loginButton, duration: 1.0, options: .transitionCrossDissolve, animations: { self.loginButton.isHidden = false }, completion: nil)
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            UIView.transition(with: self.socialStack, duration: 1.0, options: .transitionCrossDissolve, animations: { self.socialStack.isHidden = false }, completion: nil)
            
            UIView.transition(with: self.orLoginWithLabel, duration: 1.0, options: .transitionCrossDissolve, animations: { self.orLoginWithLabel.isHidden = false }, completion: nil)
            
        }
        
    }
}
    
    //MARK: Text Field Configuration
    
extension LoginViewController{
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if textField == emailInput {
                // If the user pressed return while editing the first text field, move focus to the second text field
                passwordInput.becomeFirstResponder()
            } else {
                // If the user pressed return while editing the second text field, dismiss the keyboard
                textField.resignFirstResponder()
            }
            return true
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            // Update the text label in the accessory view
            
            if textField == emailInput{
                let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
                accessoryView.textLabel.text = newText
            }
            return true
        }
        
 }


extension LoginViewController{
    
    func createLoginIcon(image: String) -> UIView{
        let image = UIImageView(image: UIImage(named: image))
        image.setDimensions(width: 32, height: 32)
        
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9294, green: 0.9294, blue: 0.9294, alpha: 1)
        view.layer.cornerRadius = 8
        
        view.addSubview(image)
        image.centerX(inView: view)
        image.centerY(inView: view)
        view.setDimensions(width: 54, height: 54)
        return view
    }
    
    
}
    
    

