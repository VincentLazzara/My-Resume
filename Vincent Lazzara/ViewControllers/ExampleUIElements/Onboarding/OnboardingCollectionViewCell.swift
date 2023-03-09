//
//  OnboardingCollectionViewCell.swift
//  Vincent Lazzara
//
//  Created by Vinny Lazzara on 3/8/23.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell{
    
    //MARK: Properties
    
    @IBOutlet weak var slideImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //MARK: Lifecycle
    
    func configure(_ slide: OnboardingSlide){
        slideImageView.image = slide.image
        titleLabel.text = slide.title
        titleLabel.font = UIFont(name: "BodoniSvtyTwoITCTT-Bold", size: 30)
        descriptionLabel.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        descriptionLabel.text = slide.description
        
        
    }
    
}
