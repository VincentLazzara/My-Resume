//
//  ExamplesViewController.swift
//  Vincent Lazzara
//
//  Created by Vinny Lazzara on 3/2/23.
//


import UIKit
import SideMenu

private let cellReuseIdentifier = "ExampleCell"
private let headerIdentifier = "ExampleHeader"

class ExamplesViewController: UITableViewController{
    
    //MARK: Properties
    
    private lazy var headerView = CustomNavigationBar()
    
    let uiTitle = ["Onboarding Screen", "Loading Animations", "Star Rating Form", "Side Menu", "Slide Up Menu",  "Log In"]
    
    let viewControllers: [UIViewController] = [
        UIStoryboard(name: "OnboardingStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "onboardingStoryboard"),
        LoadingViewController(),
        StarRatingViewController()
    
    ]
    var sideMenuContainer: UIView!
    var sideMenuVisible = false
    
    private var backgroundSheetLauncher: LinkSheetLauncher!
    
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
        tableView.register(ExampleTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.separatorColor = .lightGray
        tableView.separatorStyle = .singleLine
    }
    
    func linkPressed() {
        self.backgroundSheetLauncher = LinkSheetLauncher()
        self.backgroundSheetLauncher.delegate = self
        self.backgroundSheetLauncher.show()
    }
    
}

//MARK: Table View Set Up

extension  ExamplesViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return uiTitle.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ExampleTableViewCell
        cell.titleLabel.text = uiTitle[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        
        let menu = SideMenuNavigationController(rootViewController: MenuViewController())
        menu.leftSide = true
        switch indexPath.row{
        case 0...2: self.present(viewControllers[indexPath.row], animated: true, completion: nil)
        case 3: self.present(menu, animated: true)
        case 4: linkPressed()
        case 5: self.present(LoginViewController(), animated: true)
        default: return
        }
   
    }

    







}

extension ExamplesViewController: LinkSheetLauncherDelegate{
    func didSelect(option: LinkActionOptions) {
        UIApplication.shared.open(option.url)
    }
    
    
    
}
