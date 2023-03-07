//
//  AppScrollView.swift
//  Vincent Lazzara
//
//  Created by Vinny Lazzara on 3/3/23.
//
// let appImages = ["todoieIcon.png", "todoieIcon.png", "todoieIcon.png", "todoieIcon.png", "todoieIcon.png"]

//Horizontal scroll view for my projects. Meant to replicate how it looks on the app store
import UIKit

protocol AppScrollViewDelegate: class{
    func userDidSelect(app: String)
    
}

class AppScrollView: UIScrollView {
    
    var appDelegate: AppScrollViewDelegate?

    let appTitles = ["Black-\nScholes", "The\nSLAP", "Todoie", "See\nFood", "{V.L}"]
    let appImages = ["blackScholes.png", "theSLAP3.png", "todoieIcon.png", "seeFood.png", "VL.png"]
    var appImageViews = [UIImageView]()
    let imageViewHeight: CGFloat = 80
    let imageViewWidth: CGFloat = 80
    let imageCornerRadius: CGFloat = 12
    let titleFont: UIFont = UIFont(name: "CourierNewPS-BoldMT", size: 14)!
    let titleColor: UIColor = UIColor.white
    let titleHeight: CGFloat = 40
    let titlePadding: CGFloat = 12
    let imagePadding: CGFloat = 48

    override init(frame: CGRect) {
        super.init(frame: frame)

        // Set up the scroll view
        backgroundColor = .black
        showsHorizontalScrollIndicator = false

        // Add image views and titles for each app
        for i in 0..<appImages.count {
            let imageView = UIImageView(frame: CGRect(x: imagePadding + CGFloat(i) * (imageViewWidth + imagePadding), y: 0, width: imageViewWidth, height: imageViewHeight))
            imageView.image = UIImage(named: appImages[i])
            imageView.contentMode = .scaleAspectFill
            imageView.layer.borderWidth = 2
            imageView.layer.borderColor = UIColor.lightGray.cgColor
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = imageCornerRadius
            imageView.isUserInteractionEnabled = true
            
            let imageViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
               imageView.addGestureRecognizer(imageViewTapGesture)
            addSubview(imageView)
            appImageViews.append(imageView)

            let title = UILabel(frame: CGRect(x: imageView.frame.minX, y: imageView.frame.maxY + titlePadding, width: imageViewWidth, height: titleHeight))
            title.text = appTitles[i]
            title.font = titleFont
            title.textColor = titleColor
            title.numberOfLines = 0
            title.textAlignment = .center
            addSubview(title)

            // Add a tap gesture recognizer to the title label
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(titleLabelTapped))
            title.isUserInteractionEnabled = true
            title.addGestureRecognizer(tapGesture)
        }

        // Set the content size based on the number of images
        contentSize = CGSize(width: imagePadding * 2 + CGFloat(appImages.count) * (imageViewWidth + imagePadding), height: imageViewHeight + titlePadding + titleHeight)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    //Properties that let user select the app
    
    @objc func titleLabelTapped(sender: UITapGestureRecognizer) {
        if let tappedTitle = sender.view as? UILabel {
            if let index = appTitles.firstIndex(of: tappedTitle.text ?? "") {
                appDelegate?.userDidSelect(app: appTitles[index])
            }
        }
    }
    
    @objc func imageViewTapped(sender: UITapGestureRecognizer) {
        if let tappedImageView = sender.view as? UIImageView {
            if let index = appImageViews.firstIndex(of: tappedImageView) {
                appDelegate?.userDidSelect(app: appTitles[index])
            }
        }
    }
}
