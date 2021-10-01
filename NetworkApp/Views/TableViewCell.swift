//
//  TableViewCell.swift
//  NetworkApp
//
//  Created by Слава Платонов on 29.09.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    private var imageCharacter = CharacterImageView()
    private var nameLabel = UILabel()
    private var nicknameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(imageCharacter)
        addSubview(nameLabel)
        addSubview(nicknameLabel)
        
        configureImage()
        configureLabels()
        setImageConstrains()
        setNameLabelConstrains()
        setNicknameLabelConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageCharacter.layer.cornerRadius = imageCharacter.frame.height / 2
    }
    
    func setCharacter(character: BreakingBadCharacters) {
        nameLabel.text = character.name
        nicknameLabel.text = character.nickname
        imageCharacter.fetchImage(from: character.img)
    }
    
    // MARK: Configure UI elements
    
    private func configureImage() {
        imageCharacter.contentMode = .scaleToFill
        imageCharacter.clipsToBounds = true
    }
    
    private func configureLabels() {
        nameLabel.numberOfLines = 1
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16.5)
        nameLabel.adjustsFontSizeToFitWidth = true
        
        nicknameLabel.numberOfLines = 1
        nicknameLabel.font = UIFont.boldSystemFont(ofSize: 13)
        nicknameLabel.textColor = .lightGray
        nicknameLabel.adjustsFontSizeToFitWidth = true
    }
    
    // MARK: Setup constrains
    
    private func setImageConstrains() {
        imageCharacter.translatesAutoresizingMaskIntoConstraints = false
        imageCharacter.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageCharacter.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        imageCharacter.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageCharacter.widthAnchor.constraint(equalTo: imageCharacter.heightAnchor).isActive = true
    }
    
    private func setNameLabelConstrains() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: imageCharacter.trailingAnchor, constant: 20).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setNicknameLabelConstrains() {
        nicknameLabel.translatesAutoresizingMaskIntoConstraints = false
        nicknameLabel.centerYAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        nicknameLabel.leadingAnchor.constraint(equalTo: imageCharacter.trailingAnchor, constant: 20).isActive = true
        nicknameLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor).isActive = true
    }
}
