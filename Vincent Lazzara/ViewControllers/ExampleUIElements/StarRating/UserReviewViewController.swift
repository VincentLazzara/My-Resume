//
//  UserReviewViewController.swift
//  Vincent Lazzara
//
//  Created by Vinny Lazzara on 3/12/23.
//

import UIKit
import Cosmos

protocol UserReviewDelegate: class{
    func userDidReview(title: String, review: String, numberOfStars: Double)
}

class UserReviewViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate{
    
    
    weak var delegate: UserReviewDelegate?
    
    var userNumberOfStars: Double?
    
    lazy var placeholderText = "Review (Optional)"
    
    private let cancelLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        label.text = "Cancel"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        label.textColor = .systemBlue
        return label
    }()
    
    private let sendLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        label.text = "Send"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .systemBlue
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private let reviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        label.text = "Write a Review"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private let reviewTitleTextField: UITextField = {
        let label = UITextField()
        label.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        label.placeholder = "Title"
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    private let errorTexLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        label.text = "Error: No title"
        label.textAlignment = .center
        label.isHidden = true
        label.textColor = .red
        return label
    }()
    
    private let starView: CosmosView = {
        let star = CosmosView()
        star.rating = 0.0
        star.settings.emptyBorderColor = .systemBlue
        star.settings.filledBorderColor = .systemBlue
        star.settings.filledColor = .systemBlue
        star.settings.starSize = 25
        return star
    }()
    
    private let tapToRateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
        label.text = "Tap A Star To Rate"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .lightGray
        return label
    }()
    
    private let reviewTextView: UITextView = {
        let label = UITextView()
        label.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        label.textAlignment = .left
        label.textColor = .lightGray
        return label
    }()
    

    
    //MARK: Properties
    
    
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        let cancelGesture = UITapGestureRecognizer(target: self, action: #selector(cancelTapped))
        cancelLabel.addGestureRecognizer(cancelGesture)
        
        
        let sendGesture = UITapGestureRecognizer(target: self, action: #selector(sendTapped))
        sendLabel.addGestureRecognizer(sendGesture)

        
      let stack = UIStackView(arrangedSubviews: [cancelLabel, reviewLabel, sendLabel])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalCentering
        
        view.addSubview(stack)
        stack.centerX(inView: view, topAnchor: view.topAnchor, paddingTop: 15)
        stack.anchor(left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 20, paddingRight: 20)
        
        view.addSubview(errorTexLabel)
        errorTexLabel.centerX(inView: view, topAnchor: stack.bottomAnchor, paddingTop: 15)
        
        let starStack = UIStackView(arrangedSubviews: [starView, tapToRateLabel])
        starStack.axis = .vertical
        starStack.spacing = 4
        
        view.addSubview(starStack)
        starStack.centerX(inView: view, topAnchor: errorTexLabel.bottomAnchor, paddingTop: 15)
        
        let divider1 = createDivider()
        
        view.addSubview(divider1)
        divider1.setDimensions(width: view.frame.width - 20, height: 1)
        divider1.centerX(inView: view, topAnchor: starStack.bottomAnchor, paddingTop: 20)
        
        view.addSubview(reviewTitleTextField)
        reviewTitleTextField.setDimensions(width: view.frame.width - 40, height: 40)
        reviewTitleTextField.centerX(inView: view, topAnchor: divider1.bottomAnchor, paddingTop: 2)
        reviewTitleTextField.delegate = self
        starView.didFinishTouchingCosmos = { rating in
            self.userNumberOfStars = rating
        }
        
        let divider2 = createDivider()
        
        view.addSubview(divider2)
        divider2.setDimensions(width: view.frame.width - 20, height: 1)
        divider2.centerX(inView: view, topAnchor: reviewTitleTextField.bottomAnchor, paddingTop: 2)
        
        
        view.addSubview(reviewTextView)
        reviewTextView.setDimensions(width: view.frame.width - 40, height: 200)
        reviewTextView.centerX(inView: view, topAnchor: divider2.bottomAnchor, paddingTop: 2)
        reviewTextView.delegate = self
        reviewTextView.text = placeholderText
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         textField.resignFirstResponder()
         return true
     }
    
    @objc func cancelTapped(){
        self.dismiss(animated: true)
    }
    
    @objc func sendTapped(){
        if starView.rating == 0.0{
            errorTexLabel.text = "Add a Star Rating"
            errorTexLabel.isHidden = false
        } else if ((reviewTitleTextField.text?.isEmpty) == true){
            errorTexLabel.text = "Add A Title"
            errorTexLabel.isHidden = false
        } else{
            errorTexLabel.isHidden = true
            
            if reviewTextView.text == placeholderText{
                delegate?.userDidReview(title: reviewTitleTextField.text ?? "", review: "", numberOfStars: starView.rating)
            } else {
                delegate?.userDidReview(title: reviewTitleTextField.text ?? "", review: reviewTextView.text, numberOfStars: starView.rating)
            }
            
            self.dismiss(animated: true)
            
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == placeholderText {
                textView.text = ""
                textView.textColor = .black
            }
        }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" || textView.text == " "{
            textView.text = placeholderText
            textView.textColor = .lightGray
            
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if text == "\n" {
                textView.resignFirstResponder() // Dismiss the keyboard
                return false
            }
            return true
        }
    
    
    
}

extension UserReviewViewController{
    
    
    func createDivider() -> UIView{
        let divider = UIView()
        divider.backgroundColor = .lightGray
        return divider
    }
    
    
}
