//
//  CountryFactsViewController.swift
//  ProficiencyTest
//
//  Created by mac_admin on 29/05/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import UIKit

class CountryFactsViewController: UIViewController {

    let tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = 44.0
        view.backgroundColor = .white
        view.allowsSelection = false
        view.accessibilityIdentifier = "FactsTable"
        view.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .gray)
        view.accessibilityIdentifier = "ActivityIndicator"
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let refreshButton: UIButton = {
        let view = UIButton()
       return view
    }()
    
    
    
    open var countryFacts: CountryFacts?
    var isLoading: Bool = false
    
   
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        self.view.backgroundColor = .white
        
        self.initializeView()
        self.setConstraints()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 44.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.getFactsData()
    }
    
    func initializeView() {
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(CountryFactsViewController.refresh))
        refreshButton.accessibilityIdentifier = "RefreshButton"
        self.navigationItem.rightBarButtonItem = refreshButton
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(FactCell.self, forCellReuseIdentifier: "FactCell")
        
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        
    }
    
    func setConstraints() {
        
        let spacing: CGFloat = 8
        let metricsDictionary = ["margin": spacing]
        let viewsDictionary: [String : Any] = ["tableView": tableView]
        //self.tableView.translatesAutoresizingMaskIntoConstraints = false
        let tableViewVerticalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-margin-[tableView]-margin-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metricsDictionary, views: viewsDictionary)
        let tableViewHorizontalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-margin-[tableView]-margin-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metricsDictionary, views: viewsDictionary)
        view.addConstraints(tableViewVerticalConstraint)
        view.addConstraints(tableViewHorizontalConstraint)
        
        
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        let activityIndicatorConstraintX = NSLayoutConstraint(item: activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0)
        let activityIndicatorConstraintY = NSLayoutConstraint(item: activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0)
        view.addConstraint(activityIndicatorConstraintX)
        view.addConstraint(activityIndicatorConstraintY)
        
        
        
        
        
        
    }
    
    func getFactsData() {
        if(Utility.isConnectedToInternet()) {
            isLoading = true
            activityIndicator.startAnimating()
            
            NetworkManager.getFacts { [weak self] (facts, error) in
                
                self?.isLoading = false
                self?.activityIndicator.stopAnimating()
                
                if let countryFacts = facts {
                    self?.countryFacts = countryFacts
                    self?.title = self?.countryFacts?.title
                    self?.tableView.reloadData()
                } else if let error = error {
                        Utility.showAlert(title: Constants.ERROR, message: error.localizedDescription, buttonLabel: Constants.OK, currentVC: self)
                }
            }
        } else {
            Utility.showAlert(title: Constants.NO_INTERNET_TITLE, message: Constants.NO_INTERNET_DETAIL, buttonLabel: Constants.OK, currentVC: self)
        }
    }
    
    @objc func refresh() {
        if !isLoading {
            self.getFactsData()
        }
    }

}


