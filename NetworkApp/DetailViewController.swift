//
//  DetailViewController.swift
//  NetworkApp
//
//  Created by Слава Платонов on 29.09.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    private var nameLabel = UILabel()
    private var imageCharacter = UIImageView()
    private var activityIndicator = UIActivityIndicatorView(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        configeruNameLabel()
        configureImageView()
        setLabelConstrains()
        setImageConstrains()
        setConstrainsIndicator()
        view.backgroundColor = .white
    }
    
    func configureDetail(with character: BreakingBadCharacters) {
        title = character.nickname
        nameLabel.text = """
    Name: \(character.name)
    Nickname: \(character.nickname)
    Birthday: \(character.birthday)
    Status: \(character.status)
    """
        DispatchQueue.global().async {
            guard let imageData = NetworkManager.shared.fetchImage(from: character.img) else { return }
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.imageCharacter.image = UIImage(data: imageData)
            }
        }
    }
    
    private func configeruNameLabel() {
        let labelFrame = CGRect(x: 0, y: 0, width: 200, height: 50)
        nameLabel.frame = labelFrame
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18.5)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.sizeToFit()
        nameLabel.textColor = UIColor.black
        nameLabel.shadowColor = UIColor.lightGray
        nameLabel.shadowOffset = CGSize(width: 2, height: 2)
        view.addSubview(nameLabel)
    }
    
    private func setConstrainsIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: imageCharacter.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: imageCharacter.centerYAnchor).isActive = true
    }
    
    private func configureImageView() {
        imageCharacter.contentMode = .scaleToFill
        imageCharacter.clipsToBounds = true
        imageCharacter.layer.cornerRadius = 20
        imageCharacter.layer.borderWidth = 2
        imageCharacter.layer.borderColor = UIColor.black.cgColor
        imageCharacter.addSubview(activityIndicator)
        view.addSubview(imageCharacter)
    }
    
    private func setLabelConstrains() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: imageCharacter.bottomAnchor, constant: 30).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: imageCharacter.widthAnchor, constant: 30).isActive = true
    }
    
    private func setImageConstrains() {
        imageCharacter.translatesAutoresizingMaskIntoConstraints = false
        imageCharacter.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        imageCharacter.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        imageCharacter.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageCharacter.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30).isActive = true
    }
    
}
