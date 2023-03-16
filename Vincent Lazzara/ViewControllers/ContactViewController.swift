//
//  ContactViewController.swift
//  Vincent Lazzara
//
//  Created by Vinny Lazzara on 3/2/23.
//


import UIKit
import Contacts
import Combine
import MaterialComponents

class ContactViewController: UIViewController{
    
    //MARK: Properties
    
    private let emailService = EmailService()
    private var cancellables = Set<AnyCancellable>()
    
    var accessoryView: LoginAccessoryView!
    var nameAccessoryView: LoginAccessoryView!
    var textAccessoryView: LoginAccessoryView!
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "CourierNewPS-BoldMT", size: 18)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = "vincent.a.lazzara@gmail.com"
        return label
    }()
    
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "CourierNewPS-BoldMT", size: 18)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = "(714) 488 - 7403"
        return label
     }()
    
    let phoneIcon: UIImageView = {
        let image = UIImageView(image: UIImage(named: "telephone")?.withTintColor(.white))
        image.setDimensions(width: 24, height: 24)
        return image
     }()
    
    let emailIcon: UIImageView = {
        let image = UIImageView(image: UIImage(named: "envelope")?.withTintColor(.white))
        image.setDimensions(width: 16, height: 16)
        return image
     }()

    private let contactButton: UIButton = {
        let button = UIButton(type: .system)
        button.setDimensions(width: 200, height: 35)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont(name: "CourierNewPS-BoldMT", size: 16)
        button.setImage(UIImage(named: "phone-book"), for: .normal)
        button.imageEdgeInsets.left = -25
        button.backgroundColor = #colorLiteral(red: 0.8392, green: 0.8392, blue: 0.8392, alpha: 1)
        button.setTitle("Save My Contact", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    
    let emailInput: MDCOutlinedTextField = {
        let tf = MDCOutlinedTextField()
        tf.placeholder = "Enter Your Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.label.text = "Email"
        tf.font = UIFont(name: "CourierNewPSMT", size: 18)
        tf.setFloatingLabelColor(.cyan, for: .editing)
        tf.setOutlineColor(.white, for: .normal)
        tf.setFloatingLabelColor(.white, for: .normal)
        tf.setOutlineColor(.cyan, for: .editing)
        tf.tintColor = .white
        tf.setNormalLabelColor(.white, for: .normal)

        tf.layer.borderColor = UIColor.white.cgColor
        tf.setTextColor(.white, for: .normal)
        tf.setTextColor(.white, for: .editing)
        tf.preferredContainerHeight = 20
        tf.verticalDensity = 1
        
        tf.textAlignment = .left
        //Trying to disable predictive bar
        tf.inputAssistantItem.leadingBarButtonGroups = []
        tf.inputAssistantItem.trailingBarButtonGroups = []
        tf.keyboardType = .emailAddress
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        return tf
    }()
    
    let nameInput: MDCOutlinedTextField = {
        let tf = MDCOutlinedTextField()
        tf.placeholder = "Enter Your Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.label.text = "Name"
        tf.font = UIFont(name: "CourierNewPSMT", size: 18)
        tf.setFloatingLabelColor(.cyan, for: .editing)
        tf.setOutlineColor(.white, for: .normal)
        tf.setFloatingLabelColor(.white, for: .normal)
        tf.setOutlineColor(.cyan, for: .editing)
        tf.tintColor = .white
        tf.setNormalLabelColor(.white, for: .normal)

        tf.layer.borderColor = UIColor.white.cgColor
        tf.setTextColor(.white, for: .normal)
        tf.setTextColor(.white, for: .editing)
        tf.preferredContainerHeight = 20
        tf.verticalDensity = 1
        
        tf.textAlignment = .left
        //Trying to disable predictive bar
        tf.inputAssistantItem.leadingBarButtonGroups = []
        tf.inputAssistantItem.trailingBarButtonGroups = []
        tf.keyboardType = .alphabet
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        return tf
    }()
    
    
    let messageInput: MDCOutlinedTextArea = {
        let textArea = MDCOutlinedTextArea()
        textArea.label.text = "Message"
        textArea.leadingAssistiveLabel.text = "Message"
        textArea.sizeToFit()
        textArea.setOutlineColor(.white, for: .normal)
        textArea.setOutlineColor(.cyan, for: .editing)
        textArea.setFloatingLabel(.white, for: .normal)
        textArea.setFloatingLabel(.cyan, for: .editing)
        
        textArea.textView.font = UIFont(name: "CourierNewPSMT", size: 18)
        textArea.setNormalLabel(.white, for: .normal)

        textArea.layer.borderColor = UIColor.white.cgColor
        textArea.setTextColor(.white, for: .normal)
        textArea.setTextColor(.white, for: .editing)
        
        //Trying to disable predictive bar
        textArea.inputAssistantItem.leadingBarButtonGroups = []
        textArea.inputAssistantItem.trailingBarButtonGroups = []
        textArea.textView.keyboardType = .alphabet
        textArea.textView.autocorrectionType = .no
        textArea.textView.spellCheckingType = .no
        
        return textArea
        
    }()
    
    
    private let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setDimensions(width: 150, height: 35)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont(name: "CourierNewPS-BoldMT", size: 18)
        button.backgroundColor = .white
        button.setTitle("Send", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.tintColor = .black
        return button
    }()
    

    //MARK: Lifecycle
    
    override func viewDidLoad() {
        view.backgroundColor = .black
        
        let customNavBar = CustomNavigationBar()
        customNavBar.setDimensions(width: view.frame.width, height: 80)
        customNavBar.configureForTitle(title: "Contact Me", subtitle: "Let's chat!")
        navigationController?.navigationBar.addSubview(customNavBar)
        
        view.addSubview(contactButton)
        contactButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 70)
        
        contactButton.addTarget(self, action: #selector(checkIfContactSaved), for: .touchUpInside)
        
        let emailStack = UIStackView(arrangedSubviews: [emailIcon, emailLabel])
        emailStack.alignment = .center
        emailStack.axis = .horizontal
        emailStack.spacing = 10
        
        let phoneStack = UIStackView(arrangedSubviews: [phoneIcon, phoneLabel])
        phoneStack.alignment = .center
        phoneStack.axis = .horizontal
        phoneStack.spacing = 2
        
        let vStack = UIStackView(arrangedSubviews: [emailStack, phoneStack])
        vStack.axis = .vertical
        vStack.alignment = .leading
        vStack.spacing = 10
        
        view.addSubview(vStack)
        vStack.anchor(top: contactButton.bottomAnchor, left: view.leftAnchor, paddingTop: 30, paddingLeft: 15)
        
        let divider = UIView()
        divider.setDimensions(width: view.frame.width, height: 2)
        divider.backgroundColor = .lightGray
        
        view.addSubview(divider)
        divider.centerX(inView: view, topAnchor: vStack.bottomAnchor, paddingTop: 35)
        
        
        view.addSubview(emailInput)
        emailInput.centerX(inView: view, topAnchor: divider.bottomAnchor, paddingTop: 30)
        emailInput.setDimensions(width: view.frame.width - 35, height: 20)
        emailInput.delegate = self
        
     /*   accessoryView = LoginAccessoryView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 45))
        accessoryView.changeFont(labelFont: UIFont(name: "CourierNewPS-BoldMT", size: 16)!, textFont: UIFont(name: "CourierNewPSMT", size: 16)!)
        accessoryView.textLabel.text = "Enter your email"
        emailInput.inputAccessoryView = accessoryView */
        
        
        view.addSubview(nameInput)
        nameInput.setDimensions(width: view.frame.width - 35, height: 20)
        nameInput.centerX(inView: view, topAnchor: emailInput.bottomAnchor, paddingTop: 35)
        nameInput.delegate = self
        
     /*   nameAccessoryView = LoginAccessoryView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 45))
        nameAccessoryView.changeFont(labelFont: UIFont(name: "CourierNewPS-BoldMT", size: 16)!, textFont: UIFont(name: "CourierNewPSMT", size: 16)!)
        nameAccessoryView.textLabel.text = "Enter your name"
        nameAccessoryView.emailLabel.text = "Name:"
        nameInput.inputAccessoryView = nameAccessoryView */
        
        
   /*     textAccessoryView = LoginAccessoryView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 45))
        textAccessoryView.changeFont(labelFont: UIFont(name: "CourierNewPS-BoldMT", size: 16)!, textFont: UIFont(name: "CourierNewPSMT", size: 16)!)
        textAccessoryView.textLabel.text = "Enter Your Message"
        textAccessoryView.emailLabel.text = "Message:"
        textAccessoryView.textLabel.clipsToBounds = true */
        view.addSubview(messageInput)
        messageInput.setDimensions(width: view.frame.width - 35, height: 40)
        messageInput.centerX(inView: view, topAnchor: nameInput.bottomAnchor, paddingTop: 35)
      //  messageInput.textView.inputAccessoryView = textAccessoryView
        messageInput.textView.delegate = self
        
        
        view.addSubview(sendButton)
        sendButton.centerX(inView: view, topAnchor: messageInput.bottomAnchor, paddingTop: 60)
        sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        
        
    }
    
    
    func sendEmail(message: String){
        emailService.send(message: message)
            .receive(on: DispatchQueue.main)
            
            .sink { [weak self] completion in
            if case .failure(let error) = completion{
                print(error)
            }
        } receiveValue: { [weak self] isSuccessful in
            print(isSuccessful ? "Sent successfully" : "Did not send")
        }.store(in: &cancellables)

        
    }
    
    @objc func sendMessage(){
        var name = ""
        var email = ""
        var message = ""
        
        if let text = emailInput.text, !text.isEmpty { email = text} else { sendTextAlert(title: "Error", field: "email.") ; return}
        if let text = nameInput.text, !text.isEmpty { name = text} else { sendTextAlert(title: "Error", field: "name.") ; return}
        if let text = messageInput.textView.text, !text.isEmpty { message = text} else { sendTextAlert(title: "Error", field: "message.") ; return}
        
        sendEmail(message: "\(name) : \(email) \n \(message)")
        
        nameInput.text = nil
        emailInput.text = nil
        messageInput.textView.text = nil
        
        let alert = UIAlertController(title: "Success", message: "Your message was sent. I'll be in touch soon!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func sendTextAlert(title: String, field: String){
        let alert = UIAlertController(title: title, message: "You need to input a \(field)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    
}

//MARK: Text Field Delegate

extension ContactViewController: UITextFieldDelegate, UITextViewDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailInput {
            // If the user pressed return while editing the first text field, move focus to the second text field
            nameInput.becomeFirstResponder()
        } else if textField == nameInput{
            messageInput.textView.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    


    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
                  textView.resignFirstResponder()
                  return false
              }
        return true
    }
    
}



//MARK: Contact Configuration

extension ContactViewController{
    
    
    @objc func checkIfContactSaved(){
        
        if UserDefaults.standard.bool(forKey: "contactSaved") {
            // Ask the user if they want to save the contact again
            let alertController = UIAlertController(title: nil, message: "You have already saved this contact. Would you like to save it again?", preferredStyle: .alert)

            let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
                // Call the function to save the contact again
                self.openContactViewController()
            }
            alertController.addAction(saveAction)

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)

            present(alertController, animated: true, completion: nil)
        } else {
            // The contact has not been saved yet, so save it
            openContactViewController()
        }
   




    }
    
    @objc func openContactViewController() {

            // Create a new contact with your information
            let contact = CNMutableContact()
            contact.givenName = "Vincent"
            contact.familyName = "Lazzara"
            contact.emailAddresses = [CNLabeledValue(label: CNLabelHome, value: "vincent.a.lazzara@gmail.com")]
            
     
        
        let email = CNLabeledValue(label: CNLabelHome, value: "vincent.a.lazzara@gmail.com" as NSString)
        contact.emailAddresses = [email]
        
        contact.phoneNumbers = [CNLabeledValue(
            label: CNLabelPhoneNumberiPhone,
            value: CNPhoneNumber(stringValue: "(714) 488-7403"))]
        
        let linkedIn = CNLabeledValue(label: "LinkedIn", value: "https://www.linkedin.com/in/vincent-lazzara/" as NSString)
        let github = CNLabeledValue(label: "Github", value: "https://github.com/VincentLazzara" as NSString)
        contact.urlAddresses = [linkedIn, github]
        
        contact.note = "-iOS Developer \n-2 Years Experience"
        
        let store = CNContactStore()
        let saveRequest = CNSaveRequest()
        saveRequest.add(contact, toContainerWithIdentifier: nil)

        do {
            try store.execute(saveRequest)
            UserDefaults.standard.set(true, forKey: "contactSaved")
        } catch {
            print("Saving contact failed, error: \(error)")
            // Handle the error.
            let alertController = UIAlertController(title: nil, message: "Saving contact failed, error: \(error)", preferredStyle: .alert)

            let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alertController.addAction(okayAction)
            present(alertController, animated: true, completion: nil)
        }
        
        let alertController = UIAlertController(title: nil, message: "Successfully added Vincent Lazzara into your contacts", preferredStyle: .alert)

        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertController.addAction(okayAction)

        present(alertController, animated: true, completion: nil)
        
        
        
        }
}
