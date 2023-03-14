//
//  SideMenu.swift
//  Vincent Lazzara
//
//  Created by Vinny Lazzara on 3/12/23.
//

import UIKit
import SideMenu

private let reuseIdentifier = "SideMenuCell"

class MenuViewController: UITableViewController {
    
    private lazy var headerView = SideMenuHeader()
    
    let items: [SideMenuItem] = [
    SideMenuItem(name: "Dashboard", icon: "dashboards", notifications: 0),
    SideMenuItem(name: "Activity", icon: "activity", notifications: 10),
    SideMenuItem(name: "Tasks", icon: "checklist", notifications: 4),
    SideMenuItem(name: "Users", icon: "group", notifications: 0),
    SideMenuItem(name: "Notifications", icon: "notification", notifications: 2),
    SideMenuItem(name: "Settings", icon: "setting", notifications: 0),
    SideMenuItem(name: "Support", icon: "information", notifications: 0)
    
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.isScrollEnabled = false
        tableView.tableHeaderView = headerView
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 75)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SideMenuCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.separatorStyle = .none
        
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .white
        view.backgroundColor = #colorLiteral(red: 0, green: 0.1333, blue: 0.6784, alpha: 1)
        
   
        
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = 20
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SideMenuCell
        cell.menu = items[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.dismiss(animated: true)
    }
}



