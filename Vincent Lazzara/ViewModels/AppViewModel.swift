//
//  AppViewModel.swift
//  Vincent Lazzara
//
//  Created by Vinny Lazzara on 3/6/23.
//


import UIKit
import ImageSlideshow

//Enumeration used to populate the AppViewController

class AppViewModel{
    
    let slapInputSource: [InputSource] = {
        let inputs = [
        ImageSource(image: UIImage(named: "slap1.png")!),
        ImageSource(image: UIImage(named: "slap2.png")!),
        ImageSource(image: UIImage(named: "slap3.png")!),
        ImageSource(image: UIImage(named: "slap4.png")!),
        ImageSource(image: UIImage(named: "slap5.png")!),
        ImageSource(image: UIImage(named: "slap6.png")!),
        ImageSource(image: UIImage(named: "slap7.png")!),
        ImageSource(image: UIImage(named: "slap8.png")!),
        ImageSource(image: UIImage(named: "slap9.png")!),
        ImageSource(image: UIImage(named: "slap10.png")!),
        ImageSource(image: UIImage(named: "slap11.png")!),
        ImageSource(image: UIImage(named: "slap12.png")!),
        ImageSource(image: UIImage(named: "slap13.png")!),
        ImageSource(image: UIImage(named: "slap14.png")!),
        ImageSource(image: UIImage(named: "slap15.png")!),
        ImageSource(image: UIImage(named: "slap16.png")!),
        ImageSource(image: UIImage(named: "slap17.png")!),
        ImageSource(image: UIImage(named: "slap18.png")!),
        ImageSource(image: UIImage(named: "slap19.png")!)
        ]
        return inputs
    }()
    
    let todoInputSource: [InputSource] = {
        let inputs = [
        ImageSource(image: UIImage(named: "td0.png")!),
        ImageSource(image: UIImage(named: "td1.png")!),
        ImageSource(image: UIImage(named: "td2.png")!),
        ImageSource(image: UIImage(named: "td3.png")!),
        ImageSource(image: UIImage(named: "td4.png")!),
        ImageSource(image: UIImage(named: "td5.png")!)
        ]
        return inputs
    }()
    
    let bsInputSource: [InputSource] = {
        let inputs = [
        ImageSource(image: UIImage(named: "1.png")!),
        ImageSource(image: UIImage(named: "2.png")!),
        ImageSource(image: UIImage(named: "5.png")!),
        ImageSource(image: UIImage(named: "bs1.png")!),
        ImageSource(image: UIImage(named: "bs2.png")!),
        ImageSource(image: UIImage(named: "bs3.png")!),
        ImageSource(image: UIImage(named: "bs4.png")!),
        ImageSource(image: UIImage(named: "bs5.png")!),
        ImageSource(image: UIImage(named: "bs6.png")!),
        ImageSource(image: UIImage(named: "bs7.png")!),
        ImageSource(image: UIImage(named: "bs8.png")!),
        ImageSource(image: UIImage(named: "bs9.png")!)
        ]
        return inputs
    }()
    
    
    let sfInputSource: [InputSource] = {
        let inputs = [
        ImageSource(image: UIImage(named: "sf1.png")!),
        ImageSource(image: UIImage(named: "sf2.png")!),
        ImageSource(image: UIImage(named: "sf3.png")!),
        ImageSource(image: UIImage(named: "sf4.png")!),
        ImageSource(image: UIImage(named: "sf5.png")!)
        ]
        return inputs
    }()
    
    
    
    
}


enum projectEnumerations: Int{
    case blackScholes
    case theSLAP
    case todoie
    case seeFood
    
    
    var name: String{
        switch self{
        case .blackScholes:
            return "Black-Scholes"
        case .theSLAP:
            return "The SLAP"
        case .todoie:
            return "Todoie"
        case .seeFood:
            return "SeeFood"
        }
    }
    
    var description: String{
        switch self{
        case .blackScholes:
            return "Options & Futures calculator"
        case .theSLAP:
            return "Custom Social Media Platform"
        case .todoie:
            return "Dark / Light Mode To-Do List App"
        case .seeFood:
            return "CoreML HotDog Image Recognition"
        }
    }
    
    var appIcon: UIImage{
        switch self{
        case .blackScholes:
            return UIImage(named: "blackScholes.png")!
        case .theSLAP:
            return UIImage(named: "theSLAP3.png")!
        case .todoie:
            return UIImage(named: "todoieIcon.png")!
        case .seeFood:
            return UIImage(named: "seeFood.png")!
        }
    }
    
    var appImages: [InputSource]{
        switch self{
        case .blackScholes:
            return AppViewModel().bsInputSource
        case .theSLAP:
            return AppViewModel().slapInputSource
        case .todoie:
            return AppViewModel().todoInputSource
        case .seeFood:
            return AppViewModel().sfInputSource
        }
    }
    
    var videoURL: String{
        switch self{
        case .blackScholes:
            return "-0sbUVqFX_M"
        case .theSLAP:
            return "pgp53ncvGFQ"
        case .todoie:
            return "0Y1IegEgTb4"
        case .seeFood:
            return "e7UfYfunrzw"
        }
    }
    
    
    var appFeatures: String{
        switch self{
        case .blackScholes: return "-JSON API \n\n-Financial Formulas\n\n-Responsive UI\n\n-Cocoapods"
        case .theSLAP: return "-Firebase Auth\n\n-Firebase Data\n\n-Front-End/Back-End\n\n-User Customization"
        case .todoie: return "-Core Data \n\n-Realm\n\n-TableViews\n\n-Data Filtering"
        case .seeFood: return "-Core ML\n\n-Model Creation\n\n-CreateML"
        }
    }
    
    
    var buttonLink: String{
        switch self{
        case .blackScholes: return "https://apps.apple.com/us/app/black-scholes-calculator/id6446098641"
        case .theSLAP: return "nil"
        case.todoie: return "https://github.com/VincentLazzara/Todoie"
        case .seeFood: return "https://github.com/VincentLazzara/SeeFood"
        }
    }
}

