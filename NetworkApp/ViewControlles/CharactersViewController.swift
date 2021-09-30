//
//  CharactersViewController.swift
//  NetworkApp
//
//  Created by Слава Платонов on 29.09.2021.
//

import UIKit

class CharactersViewController: UITableViewController {
    
    private var characters: [BreakingBadCharacters] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestCharacets()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 80
        
    }
    
    private func requestCharacets() {
        NetworkManager.shared.fecthData(dataType: [BreakingBadCharacters].self, from: Links.characters.rawValue) { result in
            switch result {
            case .success(let characters):
                self.characters = characters
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let character = characters[indexPath.row]
        cell.setCharacter(character: character)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        let detailVC = DetailViewController()
        detailVC.configureDetail(with: character)
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
