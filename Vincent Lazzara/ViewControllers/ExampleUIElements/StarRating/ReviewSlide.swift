//
//  ReviewSlide.swift
//  Vincent Lazzara
//
//  Created by Vinny Lazzara on 3/9/23.
//

import UIKit

struct ReviewSlide {
    let title: String
    let description: String
    let numberOfStars: Int
    let timestamp: String
    let name: String
}



class ReviewSlideCell: UICollectionViewCell{
    
    //MARK: Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        label.text = "11/10 app"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        label.text = "3/13/23"
        label.numberOfLines = 0
        label.textAlignment = .right
        label.textColor = .gray
        return label
    }()
    
    private let starLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        label.text = "★★★☆☆"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .systemOrange
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        label.text = "name"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .gray
        return label
    }()
    
    private let reviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        label.text = "name"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    
    //MARK: Lifecycle
    func configure(_ review: ReviewSlide){
        backgroundColor = #colorLiteral(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 10)
        titleLabel.text = review.title
        
        addSubview(dateLabel)
        dateLabel.text = review.timestamp
        dateLabel.centerY(inView: titleLabel)
        dateLabel.anchor(right: rightAnchor, paddingRight: 10)
        
        addSubview(starLabel)
        starLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 10)
        starLabel.text = "\("★", repeated: review.numberOfStars)" + "\("☆", repeated: 5 - review.numberOfStars)"
        
        addSubview(nameLabel)
        nameLabel.centerY(inView: starLabel)
        nameLabel.anchor(right: rightAnchor, paddingRight: 10)
        nameLabel.text = review.name
        
        addSubview(reviewLabel)
        reviewLabel.text = review.description
        reviewLabel.anchor(top: starLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: 10)
        
        
        
    }
    
}
