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
        let star = CosmosView(frame: CGRect(x: 0, y: 0, width: 500, height: 200))
        star.settings.emptyBorderColor = .systemBlue
        star.settings.filledBorderColor = .systemBlue
        star.settings.filledColor = .systemBlue
        star.settings.starSize = 40
        return star
    }()
    
    private let progressView: UIProgressView = {
        let pv = UIProgressView()
        pv.trackTintColor = .lightGray
        pv.progressTintColor = .black
        pv.layer.cornerRadius = 4
        pv.progress = 0.60
        pv.setDimensions(width: 200, height: 4)
        return pv
    }()
    
  
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        view.addSubview(ratingsLabel)
        ratingsLabel.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 20, paddingLeft: 25)
        
        let ratingLabelStack = UIStackView(arrangedSubviews: [ratingNumberLabel, ratingExplanationLabel])
        ratingLabelStack.axis = .vertical
        ratingLabelStack.alignment = .center
        ratingLabelStack.spacing = 0

        
        
        view.addSubview(ratingLabelStack)
        ratingLabelStack.anchor(top: ratingsLabel.bottomAnchor, left: view.leftAnchor, paddingTop: 0, paddingLeft: 25)
        
        view.addSubview(progressView)
        progressView.centerX(inView: view, topAnchor: ratingLabelStack.bottomAnchor, paddingTop: 25)
        
        view.addSubview(starView)
        starView.centerX(inView: view, topAnchor: progressView.topAnchor, paddingTop: 25)
        starView.didFinishTouchingCosmos = { rating in
            self.progressView.progress = Float(rating) / 5.0
        }
    }
}
