//
//  ExamplesViewController.swift
//  Vincent Lazzara
//
//  Created by Vinny Lazzara on 3/2/23.
//


import UIKit

private let reuseIdentifier = "ExampleCell"
private let headerIdentifier = "ExampleHeader"

class ExamplesViewController: UITableViewController{
    
    //MARK: Properties
    
    private lazy var headerView = CustomNavigationBar()
    
    let uiTitle = ["Onboarding Screen", "Loading Animations", "Star Rating Form", "Side Menu", "User Post", "Settings", "Search User", "Slide Up Menu", "Contacts", "Log In", "Color Picker"]
    
    let viewControllers: [UIViewController] = [UIStoryboard(name: "OnboardingStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "onboardingStoryboard"),LoadingViewController()
                                            
    
    
    
    ]
    
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        view.backgroundColor = .black
        navigationController?.navigationBar.barStyle = .black
        tabBarController?.tabBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        
        configureTableview()
    }
    
    func configureTableview(){
        headerView.configureForTitle(title: "UI Examples", subtitle: "Take a look at some of the example UI elements I created")
        tableView.tableHeaderView = headerView
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 100)
        tableView.register(ExampleTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.separatorColor = .lightGray
        tableView.separatorStyle = .singleLine
    }
    
}

//MARK: Table View Set Up

extension  ExamplesViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return uiTitle.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ExampleTableViewCell
        cell.titleLabel.text = uiTitle[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0{
            self.present(viewControllers[indexPath.row], animated: true, completion: nil)
        } else if indexPath.row == 1{
            self.present(viewControllers[indexPath.row], animated: true, completion: nil)
        }
    }
}
