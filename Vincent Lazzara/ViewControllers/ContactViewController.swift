//
//  ContactViewController.swift
//  Vincent Lazzara
//
//  Created by Vinny Lazzara on 3/2/23.
//


import UIKit
import Contacts

class ContactViewController: UIViewController{
    
    //MARK: Properties
    
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
    
    private let apiKey = "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"

    private let contactButton: UIButton = {
        let button = UIButton(type: .system)
        button.setDimensions(width: 200, height: 35)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont(name: "CourierNewPS-BoldMT", size: 16)
        button.setImage(UIImage(named: "phone-book"), for: .normal)
        button.imageEdgeInsets.left = -25
        button.backgroundColor = .white
        button.setTitle("Save My Contact", for: .normal)
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
        contactButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 65)
        
        contactButton.addTarget(self, action: #selector(checkIfContactSaved), for: .touchUpInside)
        
        let emailStack = UIStackView(arrangedSubviews: [emailIcon, emailLabel])
        emailStack.alignment = .center
        emailStack.axis = .horizontal
        emailStack.spacing = 10
        
        let phoneStack = UIStackView(arrangedSubviews: [phoneIcon, phoneLabel])
        phoneStack.alignment = .center
        phoneStack.axis = .horizontal
        phoneStack.spacing = 10
        
        let vStack = UIStackView(arrangedSubviews: [emailStack, phoneStack])
        vStack.axis = .vertical
        vStack.alignment = .center
        vStack.spacing = 10
        
        view.addSubview(vStack)
        vStack.centerX(inView: view, topAnchor: contactButton.bottomAnchor, paddingTop: 20)
        
        
    }
    
}


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
