//
//  CountryFactsViewController + TableView.swift
//  ProficiencyTest
//
//  Created by mac_admin on 29/05/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import UIKit
import Kingfisher

extension CountryFactsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countryFacts?.factsFiltered?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FactCell = tableView.dequeueReusableCell(withIdentifier: "FactCell", for: indexPath) as! FactCell
        if let facts = self.countryFacts {
            if let factItem = facts.factsFiltered?[indexPath.row] {
                cell.lblTitle.text = factItem.title
                cell.lblDescription.text = factItem.description
                cell.imgView.backgroundColor = .clear
                cell.imgView.image = UIImage(named: "PlaceHolder")
                if let url = factItem.imageHref, let urlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
                    
                    cell.imgView.kf.setImage(with: URL(string: urlString), placeholder: UIImage(named: "PlaceHolder"), options: [.forceRefresh])
                   // cell.imgView.kf.setImage(with: , placeholder: , options: nil, progressBlock: nil, completionHandler: nil)
                   
                }

                
            }
            
        }
        
        return cell
    }
    
    
}
