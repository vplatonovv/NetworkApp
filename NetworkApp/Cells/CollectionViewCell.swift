//
//  CollectionViewCell.swift
//  NetworkApp
//
//  Created by Слава Платонов on 29.09.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var infoLabel = UILabel()
    var imageSeason = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageSeason.addSubview(infoLabel)
        addSubview(imageSeason)
        configureInfoLabel()
        setConstrainsInfoLabel()
        configureImage()
        setConstrainsImageSeason()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with seasons: String, image: String) {
        infoLabel.text = seasons
        imageSeason.image = UIImage(named: image)
    }
    
    private func configureImage() {
        imageSeason.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        imageSeason.contentMode = .scaleToFill
        imageSeason.clipsToBounds = true
        imageSeason.image = UIImage(named: seasonImages[0])
        imageSeason.layer.cornerRadius = 20
        imageSeason.alpha = 0.8
    }
    
    private func configureInfoLabel() {
        infoLabel.adjustsFontSizeToFitWidth = true
        infoLabel.frame = CGRect(x: 0, y: 0, width: frame.width - 48, height: frame.height - 20)
        infoLabel.font = UIFont.boldSystemFont(ofSize: 50)
        infoLabel.textColor = .white
        infoLabel.shadowColor = UIColor.lightGray
        infoLabel.shadowOffset = CGSize(width: 2, height: 2)
    }
    
    private func setConstrainsInfoLabel() {
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        infoLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func setConstrainsImageSeason() {
        imageSeason.translatesAutoresizingMaskIntoConstraints = false
        imageSeason.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageSeason.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageSeason.widthAnchor.constraint(equalToConstant: bounds.width).isActive = true
        imageSeason.heightAnchor.constraint(equalToConstant: bounds.height).isActive = true
    }
}


