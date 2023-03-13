//
//  StarRatingViewController.swift
//  Vincent Lazzara
//
//  Created by Vinny Lazzara on 3/9/23.
//

import UIKit
import Cosmos
import Charts


let reviewReuseIdentifier = "ReviewCell"

class StarRatingViewController: UIViewController{
    
    //MARK: Properties

    
    var reviews = [5.0, 5.0, 5.0, 5.0, 5.0, 4.0, 4.0, 5.0]
    var didReview = false
    
    var number5Stars = 6.0
    var number4Stars = 2.0
    var number3Stars = 0.0
    var number2Stars = 0.0
    var number1Stars = 0.0
    
    var reviewSlides: [ReviewSlide] = [
    ReviewSlide(title: "11/10 App", description: "He recreated the app store review page in using just UI Kit. what type of mad man does that??", numberOfStars: 5, timestamp: "3/12/23", name: "Dylan"),
    ReviewSlide(title: "Amazing", description: "So much prettier than just a pdf resume. Very creative.", numberOfStars: 5, timestamp: "3/10/23", name: "Eliza"),
    ReviewSlide(title: "Not Enough", description: "This app is so amazing but I wish there was more of it. I'm leaving four stars because its so good I want more. Also to add some diversification in the average rating.", numberOfStars: 4, timestamp: "3/1/23", name: "Taylor")
    ]
    
    lazy var currentIndex = 1
    
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
        label.text = "4.7"
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
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()

    
    private let starView: CosmosView = {
        let star = CosmosView()
        star.rating = 0.0
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
    
    private let editLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        label.text = "Write A Review"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .systemBlue
        return label
    }()
    
    private let editImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "edit")!.withRenderingMode(.alwaysTemplate))
        image.setDimensions(width: 24, height: 24)
        image.tintColor = .systemBlue
        return image
    }()
    
    //Progress view for corresponding number of stars
    lazy var progressView5 = createProgressView()
    lazy var progressView4 = createProgressView()
    lazy var progressView3 = createProgressView()
    lazy var progressView2 = createProgressView()
    lazy var progressView1 = createProgressView()
    
    
    
  
    
    //MARK: Lifecycle
    
    var timer: Timer?
    
    func startTimer() {
        var currentIndex = 0
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            currentIndex = (currentIndex + 1) % 3

            let newIndexPath = IndexPath(item: currentIndex, section: 0)
            self.collectionView.scrollToItem(at: newIndexPath, at: .centeredHorizontally, animated: true)
        }}

    
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
        
        collectionView.register(ReviewSlideCell.self, forCellWithReuseIdentifier: reviewReuseIdentifier)
        collectionView.setDimensions(width: 325, height: 250)
        view.addSubview(collectionView)
        collectionView.layer.cornerRadius = 15
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            collectionView.setCollectionViewLayout(layout, animated: true)
        }
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.backgroundColor = #colorLiteral(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
        collectionView.centerX(inView: view, topAnchor: starView.bottomAnchor, paddingTop: 35)
        
        let editStack = UIStackView(arrangedSubviews: [editImage, editLabel])
        editStack.axis = .horizontal
        editStack.alignment = .center
        
        view.addSubview(editStack)
        editStack.centerX(inView: view, topAnchor: collectionView.bottomAnchor, paddingTop: 18)
        editStack.spacing = 8
        
        let editGesture = UITapGestureRecognizer(target: self, action: #selector(writeReviewTapped))
        editStack.addGestureRecognizer(editGesture)
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if reviewSlides.count == 1{
            print("User already has a review, no timer enabled")
        } else{
            self.startTimer()
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
        pv.trackTintColor = #colorLiteral(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
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
        
        var totalReviews = 0.0
        
        for num in self.reviews{
            switch num{
            case 5.0: number5Stars += 1.0 ; totalReviews += 5
            case 4.0: number4Stars += 1.0 ; totalReviews += 4
            case 3.0: number3Stars += 1.0 ; totalReviews += 3
            case 2.0: number2Stars += 1.0 ; totalReviews += 2
            case 1.0: number1Stars += 1.0 ; totalReviews += 1
            default: print("Number not found")
            }
            
        }
        print("After append: \(self.reviews)")
        print("After number 5 \(self.number5Stars)")
        
        let averageReviews = (totalReviews / Double(reviews.count)).rounded(toPlaces: 1)
        ratingNumberLabel.text = "\(averageReviews)"
        calculateProgressViews()
        
    }
    
    func calculateProgressViews(){
        progressView5.progress = Float(number5Stars / Double(reviews.count))
        progressView4.progress = Float(number4Stars / Double(reviews.count))
        progressView3.progress = Float(number3Stars / Double(reviews.count))
        progressView2.progress = Float(number2Stars / Double(reviews.count))
        progressView1.progress = Float(number1Stars / Double(reviews.count))
    }
    
    @objc func writeReviewTapped(){
        let nav = UserReviewViewController()
        nav.delegate = self
        self.present(nav, animated: true)
    }
    
    
}


//MARK: Collection View 
extension StarRatingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviewSlides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewReuseIdentifier, for: indexPath) as! ReviewSlideCell
        cell.configure(reviewSlides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        timer?.invalidate()
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        timer?.invalidate()
    }
    
}


extension StarRatingViewController: UserReviewDelegate{
    func userDidReview(title: String, review: String, numberOfStars: Double) {
        timer?.invalidate()
        self.starView.rating = numberOfStars
        self.starView.isUserInteractionEnabled = false
        self.reviewSlides = [ReviewSlide(title: title, description: review, numberOfStars: Int(numberOfStars), timestamp: "Just Now", name: "Your Review")]
        self.tapToRateLabel.text = "Your Rating:"
        self.recalculateReviews(review: numberOfStars)
        self.editLabel.text = "Write A New Review"
        collectionView.reloadData()
    }
    
    
    
}

extension String.StringInterpolation {
    mutating func appendInterpolation(_ str: String, repeated n: Int) {
        appendLiteral(String(repeating: str, count: n))
    }
}

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}


