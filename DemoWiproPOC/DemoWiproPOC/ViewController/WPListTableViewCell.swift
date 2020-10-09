//
//  WPListTableViewCell.swift
//  DemoWiproPOC
//
//  Created by Piyush on 08/10/20.
//  Copyright © 2020 Piyush. All rights reserved.
//

import UIKit
import SDWebImage

class WPListTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        let margin_contentView = self.contentView.layoutMarginsGuide
        let margin_ImageView = self.imageView?.layoutMarginsGuide
        let margin_textLabel = self.textLabel?.layoutMarginsGuide
        self.textLabel?.numberOfLines = 0
        self.detailTextLabel?.numberOfLines = 0
        self.imageView?.translatesAutoresizingMaskIntoConstraints = false
        self.imageView?.topAnchor.constraint(equalTo: margin_contentView.topAnchor,constant: 0).isActive = true
        self.imageView?.leadingAnchor.constraint(equalTo: margin_contentView.leadingAnchor,constant: 0).isActive = true
        self.imageView?.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.imageView?.widthAnchor.constraint(equalToConstant: 40).isActive = true
        self.imageView?.contentMode = .scaleAspectFill
        self.imageView?.layer.cornerRadius = 20
        self.textLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.textLabel?.topAnchor.constraint(equalTo: margin_contentView.topAnchor,constant: 0).isActive = true
        self.textLabel?.leadingAnchor.constraint(equalTo: margin_ImageView!.leadingAnchor, constant: 50).isActive = true
        
        self.detailTextLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.detailTextLabel?.topAnchor.constraint(equalTo: margin_textLabel!.topAnchor,constant: 20).isActive = true
        
        self.detailTextLabel?.leadingAnchor.constraint(equalTo: margin_ImageView!.leadingAnchor, constant: 50).isActive = true
        self.detailTextLabel?.trailingAnchor.constraint(equalTo: margin_contentView.trailingAnchor, constant: 0).isActive = true
        self.detailTextLabel?.bottomAnchor.constraint(equalTo: margin_contentView.bottomAnchor, constant: 0).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCellInfo(info:Rows) {
        self.textLabel?.text = info.title ?? "N/A"
        self.detailTextLabel?.text = info.description  ?? "N/A"
        self.imageView?.sd_setImage(with: URL(string: info.imageHref ?? ""), placeholderImage: UIImage(named: "placeHolderImgIcon"))
        
    }
    
    
}
