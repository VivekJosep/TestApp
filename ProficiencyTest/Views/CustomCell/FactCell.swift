//
//  FactCell.swift
//  ProficiencyTest
//
//  Created by mac_admin on 29/05/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import UIKit

class FactCell: UITableViewCell {

    var imgView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var lblTitle: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.textAlignment = .left
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 13)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var lblDescription: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textAlignment = .left
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 12)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    
    }
    
    override func updateConstraints() {
        super.updateConstraints()
    }
    
    private func setView() {
        contentView.addSubview(imgView)
        contentView.addSubview(lblTitle)
        contentView.addSubview(lblDescription)
        
        setConstraints()
        
    }
    
    private func setConstraints() {
        let spacing: CGFloat = 8
        let metricsDictionary = ["margin": spacing , "imageHeight": 64, "imageWidth": 64]
        let viewDictionary = ["image": imgView, "title": lblTitle, "description": lblDescription] as [String: Any]
        let constraintImageHeight = NSLayoutConstraint.constraints(withVisualFormat: "H:[image(imageHeight)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metricsDictionary, views: viewDictionary)
        let constraintImageWidth = NSLayoutConstraint.constraints(withVisualFormat: "V:[image(imageWidth)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metricsDictionary, views: viewDictionary)
        imgView.addConstraints(constraintImageWidth)
        imgView.addConstraints(constraintImageHeight)
        
        let constraintImageVertical = NSLayoutConstraint.constraints(withVisualFormat: "V:|-margin-[image]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metricsDictionary, views: viewDictionary)
        let constraintTitleVertical = NSLayoutConstraint.constraints(withVisualFormat: "V:|-margin-[title]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metricsDictionary, views: viewDictionary)
        let constraintImageAndTitleHorizontal = NSLayoutConstraint.constraints(withVisualFormat: "H:|-margin-[image]-margin-[title]-margin-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metricsDictionary, views: viewDictionary)
        let constraintDescriptionTop = NSLayoutConstraint(item: lblDescription, attribute: .top, relatedBy: .equal, toItem: lblTitle, attribute: .bottom, multiplier: 1.0, constant: spacing)
        let constraintDescriptionBottom = NSLayoutConstraint(item: lblDescription, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: -spacing)
        constraintDescriptionBottom.priority = UILayoutPriority(rawValue: 999)
        let constraintDescriptionHorizontal = NSLayoutConstraint.constraints(withVisualFormat: "H:|-margin-[image]-margin-[description]-margin-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metricsDictionary, views: viewDictionary)
        let descriptionMinimumHeight: CGFloat = 40
        let constraintDescriptionHeight = NSLayoutConstraint(item: lblDescription, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: descriptionMinimumHeight)
        lblDescription.addConstraint(constraintDescriptionHeight)
        
        contentView.addConstraint(constraintDescriptionTop)
        contentView.addConstraint(constraintDescriptionBottom)
        
        contentView.addConstraints(constraintImageVertical)
        contentView.addConstraints(constraintTitleVertical)
        contentView.addConstraints(constraintImageAndTitleHorizontal)
        contentView.addConstraints(constraintDescriptionHorizontal)
        
    }

}
