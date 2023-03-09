//
//  OnboardingViewController.swift
//  Vincent Lazzara
//
//  Created by Vinny Lazzara on 3/7/23.
//

import UIKit

private let reuseIdentifier = "onboardingCell"

class OnboardingViewController: UIViewController{
    
    //MARK: Properties

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    
    var slides: [OnboardingSlide] = []
    
    var currentPage = 0{
        didSet{
            if currentPage == slides.count - 1{
                nextButton.setTitle("Let's Go", for: .normal)
            } else{
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    
    
    //MARK: Lifecycle
    
    
    override func viewDidLoad() {
         view.backgroundColor = .white
        slides = [
            OnboardingSlide(title: "Finally...", description: "...An IOS Developer you can trust", image: UIImage(named: "si1")!),
            OnboardingSlide(title: "All Custom.", description: "This was made entirely with a Storyboard & UIKit", image: UIImage(named: "si2")!),
            OnboardingSlide(title: "Add Screens With Ease.", description: "Created with the best coding practices for scability", image: UIImage(named: "si3")!),
            OnboardingSlide(title: "Let's Connect.", description: "Reach out to set up an interview today!", image: UIImage(named: "si4")!),
        ]
        
        pageControl.numberOfPages = slides.count
        
      /*  UIFont.familyNames.forEach({ familyName in
                   let fontNames = UIFont.fontNames(forFamilyName: familyName)
                   print(familyName, fontNames)
               }) */
        
        nextButton.layer.cornerRadius = 12
        nextButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
        if currentPage == slides.count - 1{
            self.dismiss(animated: true)
        } else{
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            pageControl.page = currentPage
        }
        
     
    }
    
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.configure(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        pageControl.page = currentPage
    }
}
