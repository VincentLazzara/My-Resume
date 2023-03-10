//
//  StarRatingViewController.swift
//  Vincent Lazzara
//
//  Created by Vinny Lazzara on 3/9/23.
//

import UIKit
import Cosmos
import Charts

class StarRatingViewController: UIViewController{
    
    //MARK: Properties

    
    var reviews = [5.0, 5.0, 4.0, 5.0, 3.0, 4.0, 1.0, 5.0]
    var didReview = false
    
    var number5Stars = 4.0
    var number4Stars = 2.0
    var number3Stars = 1.0
    var number2Stars = 0.0
    var number1Stars = 1.0
    
    private let lightColor = #colorLiteral(red: 0.7882, green: 0.7882, blue: 0.7882, alpha: 1)
    
    private let ratingsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 24)
        label.text = "Vincent Lazzara \nRatings & Reviews"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    private let ratingNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 64)
        label.text = "4.8"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    private let ratingExplanationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
        label.text = "out of 5"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }()

    
    private let starView: CosmosView = {
        let star = CosmosView()
        star.settings.emptyBorderColor = .systemBlue
        star.settings.filledBorderColor = .systemBlue
        star.settings.filledColor = .systemBlue
        star.settings.starSize = 35
        return star
    }()
    
    lazy var tapToRateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 19)
        label.text = "Tap To Rate:"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = lightColor
        return label
    }()
    
    //Progress view for corresponding number of stars
    lazy var progressView5 = createProgressView()
    lazy var progressView4 = createProgressView()
    lazy var progressView3 = createProgressView()
    lazy var progressView2 = createProgressView()
    lazy var progressView1 = createProgressView()
  
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        calculateProgressViews()
        view.addSubview(ratingsLabel)
        ratingsLabel.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 20, paddingLeft: 25)
        
        let ratingLabelStack = UIStackView(arrangedSubviews: [ratingNumberLabel, ratingExplanationLabel])
        ratingLabelStack.axis = .vertical
        ratingLabelStack.alignment = .center
        ratingLabelStack.spacing = 0

        
        
        view.addSubview(ratingLabelStack)
        ratingLabelStack.anchor(top: ratingsLabel.bottomAnchor, left: view.leftAnchor, paddingTop: 10, paddingLeft: 25)
        
        let ratingLabel5 = createStarLabel(numberOfStars: 5)
        let stack5 = createStackView(label: ratingLabel5, progress: progressView5)
        
        let ratingLabel4 = createStarLabel(numberOfStars: 4)
        let stack4 = createStackView(label: ratingLabel4, progress: progressView4)
        
        let ratingLabel3 = createStarLabel(numberOfStars: 3)
        let stack3 = createStackView(label: ratingLabel3, progress: progressView3)
        
        let ratingLabel2 = createStarLabel(numberOfStars: 2)
        let stack2 = createStackView(label: ratingLabel2, progress: progressView2)
        
        let ratingLabel1 = createStarLabel(numberOfStars: 1)
        let stack1 = createStackView(label: ratingLabel1, progress: progressView1)
        
        
        let starStack = UIStackView(arrangedSubviews: [stack5, stack4, stack3, stack2, stack1])
        starStack.axis = .vertical
        starStack.alignment = .trailing
        starStack.spacing = 0
    
        view.addSubview(starStack)
        starStack.anchor(top: ratingNumberLabel.topAnchor, right: view.rightAnchor, paddingTop: 20, paddingRight: 15)
        
        let dividerView = UIView()
        dividerView.backgroundColor = lightColor
        dividerView.setDimensions(width: view.frame.width / 1.1, height: 2)
        
        view.addSubview(dividerView)
        dividerView.centerX(inView: view, topAnchor: starStack.bottomAnchor, paddingTop: 25)
        
        view.addSubview(starView)
        starView.anchor(top: dividerView.bottomAnchor, right: starStack.rightAnchor, paddingTop: 20, paddingRight: 0)
        
        view.addSubview(tapToRateLabel)
        tapToRateLabel.centerY(inView: starView)
        tapToRateLabel.anchor(right: starView.leftAnchor, paddingRight: 30)
         
        
        starView.didFinishTouchingCosmos = { rating in
            self.recalculateReviews(review: rating)
        }
    }
}


extension StarRatingViewController{
    
    func createStarLabel(numberOfStars: Int) -> UILabel{
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 12)
        label.text = "\("★", repeated: numberOfStars)"
        label.numberOfLines = 0
        label.textAlignment = .right
        label.textColor = .darkGray
        return label
        
    }
    
    func createProgressView() -> UIProgressView{
        let pv = UIProgressView()
        pv.trackTintColor = .lightGray
        pv.progressTintColor = .black
        pv.layer.cornerRadius = 4
        pv.progress = 0.60
        pv.setDimensions(width: 125, height: 4)
        return pv
        
    }
    
    func createStackView(label: UILabel, progress: UIProgressView) -> UIStackView{
        let ratingLabelStack = UIStackView(arrangedSubviews: [label, progress])
        ratingLabelStack.axis = .horizontal
        ratingLabelStack.alignment = .center
        ratingLabelStack.spacing = 10
        return ratingLabelStack
        
    }
    
    func recalculateReviews(review: Double){
        
        if didReview{
            self.reviews[8] = review
        } else{
            self.reviews.append(review)
            self.didReview = true
        }
        number5Stars = 0.0
        number4Stars = 0.0
        number3Stars = 0.0
        number2Stars = 0.0
        number1Stars = 0.0
        
        for num in self.reviews{
            switch num{
            case 5.0: number5Stars += 1.0
            case 4.0: number4Stars += 1.0
            case 3.0: number3Stars += 1.0
            case 2.0: number2Stars += 1.0
            case 1.0: number1Stars += 1.0
            default: print("Number not found")
            }
            
        }
        print("After append: \(self.reviews)")
        print("After number 5 \(self.number5Stars)")
        calculateProgressViews()
        
    }
    
    func calculateProgressViews(){
        progressView5.progress = Float(number5Stars / Double(reviews.count))
        progressView4.progress = Float(number4Stars / Double(reviews.count))
        progressView3.progress = Float(number3Stars / Double(reviews.count))
        progressView2.progress = Float(number2Stars / Double(reviews.count))
        progressView1.progress = Float(number1Stars / Double(reviews.count))
    }
    
    
}

extension String.StringInterpolation {
    mutating func appendInterpolation(_ str: String, repeated n: Int) {
        appendLiteral(String(repeating: str, count: n))
    }
}
