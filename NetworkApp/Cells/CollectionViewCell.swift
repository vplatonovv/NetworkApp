//
//  CollectionViewCell.swift
//  NetworkApp
//
//  Created by Слава Платонов on 29.09.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var infoLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(infoLabel)
        configureInfoLabel()
        setConstrainsInfoLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureInfoLabel() {
        infoLabel.adjustsFontSizeToFitWidth = true
        infoLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        infoLabel.text = "Season 1"
    }
    
    private func setConstrainsInfoLabel() {
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        infoLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}


