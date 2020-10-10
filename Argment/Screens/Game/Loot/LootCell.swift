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
        img.contentMode = .scaleAspectFit // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.clipsToBounds = true
        return img
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleLabel: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        textView.textColor = .lightText
        textView.isUserInteractionEnabled = false
        textView.textContainer.maximumNumberOfLines = 3
        textView.backgroundColor = .none
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
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
           imageView.contentMode = .scaleAspectFit
           imageView.isHidden = true
           return imageView
       }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        selectedBackgroundView = nil
    }

    private func setupCell() {
        contentView.addSubview(container)
        for view in [foodImage, titleLabel, subtitleLabel] {
            container.addSubview(view)
        }
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            
            foodImage.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 22),
            foodImage.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: 6),
            foodImage.widthAnchor.constraint(equalToConstant: 96),
            foodImage.heightAnchor.constraint(equalToConstant: 72),
            
            titleLabel.leadingAnchor.constraint(equalTo: foodImage.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -24),
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 6),
            titleLabel.heightAnchor.constraint(equalToConstant: 22),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: foodImage.trailingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -24),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            subtitleLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8),

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
        titleLabel.text = data.title
        subtitleLabel.text = data.description
        container.backgroundColor = data.color
    }
}
