//
//  TreasureCell.swift
//  Argment
//
//  Created by hladek on 19/07/2020.
//  Copyright © 2020 hladek. All rights reserved.
//

import Foundation
import UIKit

class LootCell: UITableViewCell {
    let foodImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textColor =  .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    let selectorView: UIView = {
        let imageView = UIImageView()
        imageView.image = .selection
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        selectorView.isHidden = !selected
    }
    
    private func setupCell() {
        contentView.addSubview(container)
        for view in [foodImage, nameLabel, selectorView] {
            container.addSubview(view)
        }
        selectorView.frame = container.bounds
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            
            foodImage.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 22),
            foodImage.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: 6),
            foodImage.widthAnchor.constraint(equalToConstant: 72),
            foodImage.heightAnchor.constraint(equalToConstant: 72),
            
            nameLabel.leadingAnchor.constraint(equalTo: foodImage.trailingAnchor, constant: 24),
            nameLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -24),
            nameLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 6),
            nameLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -6),
            
            
            selectorView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            selectorView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            selectorView.topAnchor.constraint(equalTo: container.topAnchor),
            selectorView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
    
            contentView.heightAnchor.constraint(equalToConstant: 132)
        ])
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40))
        contentView.backgroundColor = .clear
        self.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func load(data: Chest) {
        foodImage.image = data.image
        nameLabel.text = data.description
        container.backgroundColor =  data.color
    }
}
