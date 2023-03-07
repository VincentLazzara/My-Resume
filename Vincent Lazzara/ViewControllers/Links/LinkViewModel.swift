//
//  LinkViewModel.swift
//  Vincent Lazzara
//
//  Created by Vinny Lazzara on 3/7/23.
//


import Foundation
import UIKit

struct LinkSheetViewModel{
    var option: [LinkActionOptions]{
        var results = [LinkActionOptions]()
        results.append(.linkedIn)
        results.append(.gitHub)
        return results
    }
}

enum LinkActionOptions{
    case linkedIn
    case gitHub
    
    var title: String{
        switch self{
        case .linkedIn: return "LinkedIn"
        case .gitHub: return "GitHub"
        }
    }
    
    var image: UIImage{
        switch self{
        case .linkedIn:
            return UIImage(named: "linkedin.png")!
        case .gitHub:
            return UIImage(named: "github.png")!
        }
    }
    
    var url: URL{
        switch self{
        case .linkedIn: return URL(string: "https://www.linkedin.com/in/vincent-lazzara/")!
        case .gitHub: return URL(string: "https://github.com/VincentLazzara")!
        }
    }
}

