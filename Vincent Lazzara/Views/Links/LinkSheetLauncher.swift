//
//  LinkSheetLauncher.swift
//  Vincent Lazzara
//
//  Created by Vinny Lazzara on 3/7/23.
//

import UIKit

protocol LinkSheetLauncherDelegate: class {
    func didSelect(option: LinkActionOptions)
}

private let reuseIdentifier = "LinkSheetCell"
class LinkSheetLauncher: NSObject{
    
    //MARK: Properties

    weak var delegate: LinkSheetLauncherDelegate?
    
    private let tableView = UITableView()
    private var window: UIWindow?
    private lazy var viewModel = LinkSheetViewModel()
    private var tableViewHeight: CGFloat?
    
    private lazy var blackView: UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = UIFont(name: "CourierNewPS-BoldMT", size: 24)
        button.backgroundColor = .systemGroupedBackground
        button.setTitleColor(.darkGray, for: .normal)
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        return button
    }()
    
    private lazy var footerView: UIView = {
        let view = UIView()
        view.addSubview(cancelButton)
        cancelButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        cancelButton.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight:16)
        cancelButton.centerY(inView: view)
        cancelButton.layer.cornerRadius = 12
        return view
    }()
    
    
    //MARK: LifeCycle
    
    override init(){
        super.init()
        configureTableView()
    }
    
    //MARK: Selectors
    
    @objc func handleDismissal(){
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            self.tableView.frame.origin.y += 300
        }
        
    }
    
    //MARK: Helpers
    
    func showTableView(_ shouldShow: Bool){
        
        //Shows table view. Set true to show, false to dismiss
        
        guard let window = window else {return}
        guard let height = tableViewHeight else {return}
        let y = shouldShow ? window.frame.height - height : window.frame.height
        tableView.frame.origin.y = y
    }
    
    func show(){
        guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else {return}

        self.window = window
        window.addSubview(blackView)
        blackView.frame = window.frame
        
        window.addSubview(tableView)
        let height = CGFloat(viewModel.option.count * 60) + 60
        self.tableViewHeight = height
        tableView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
      
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 1
            self.showTableView(true)
        }
    }
    
    
    func configureTableView(){
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 60
        tableView.layer.cornerRadius = 8
        tableView.isScrollEnabled = false
        
        
        tableView.register(LinkSheetCell.self, forCellReuseIdentifier: reuseIdentifier)
        
          tableView.sectionHeaderTopPadding = 20
      
        
    }
}

extension LinkSheetLauncher: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return footerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = viewModel.option[indexPath.row]
        
        UIView.animate(withDuration: 0.5, animations: {
            self.blackView.alpha = 0
            self.showTableView(false)
            
        }) { _ in
                self.delegate?.didSelect(option: option)
            }

    }
    
  
}

extension LinkSheetLauncher: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.option.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! LinkSheetCell
        cell.option = viewModel.option[indexPath.row]
        return cell
    }
    
    
    
}

