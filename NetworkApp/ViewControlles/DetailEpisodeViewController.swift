//
//  DetailEpisodeViewController.swift
//  NetworkApp
//
//  Created by Слава Платонов on 29.09.2021.
//

import UIKit

class DetailEpisodeViewController: UIViewController {
    
    var characters: [String] = []
    private var label = UILabel()
    private var tableView = UITableView(frame: CGRect(), style: .plain)
    private var imageView = UIImageView(image: UIImage(named: "logo"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabel()
        setConstrainsLabel()
        configureTableView()
        setConstrainsTable()
        configureImage()
        setConstrainsImage()
        view.backgroundColor = .systemBackground
    }
    
    func configureDetail(with episode: BreakingBadEpisodes) {
        label.text = "Title: \(episode.title), season: \(episode.season), episode: \(episode.episode), air date: \(episode.airDate)"
    }
    
    // MARK: Configure UI elements
    
    private func configureImage() {
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.black.cgColor
        view.addSubview(imageView)
    }
    
    private func configureLabel() {
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20)
        view.addSubview(label)
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "char")
        view.addSubview(tableView)
    }
    
    // MARK: Setup constrains
    
    private func setConstrainsLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30).isActive = true
        label.widthAnchor.constraint(equalToConstant: view.frame.width / 1.1).isActive = true
    }
    
    private func setConstrainsTable() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: view.frame.height / 2).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setConstrainsImage() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 7).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: view.frame.height / 4).isActive = true
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource

extension DetailEpisodeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "char", for: indexPath)
        let character = characters[indexPath.row]
        cell.textLabel?.text = character
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Characters"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
