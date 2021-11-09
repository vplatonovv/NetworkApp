//
//  CharactersViewController.swift
//  NetworkApp
//
//  Created by Слава Платонов on 29.09.2021.
//

import UIKit

class CharactersViewController: UITableViewController {
    
    private var characetsCoreData: [Characters] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        requestCharacets()
    }
    
    private func requestCharacets() {
        StorageManager.shared.fetchData { [unowned self] result in
            switch result {
            case .success(let characters):
                self.characetsCoreData = characters
                print("Data from core data")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        checkCharactersInCoreDataStack()
    }
    
    private func checkCharactersInCoreDataStack() {
        if characetsCoreData.isEmpty {
            NetworkManager.shared.fecthData(
                dataType: [BreakingBadCharacters].self,
                from: Links.characters.rawValue) { result in
                    switch result {
                    case .success(let characters):
                        characters.forEach { character in
                            StorageManager.shared.save(name: character.name,
                                                       birthday: character.birthday,
                                                       img: character.img,
                                                       status: character.status,
                                                       nickname: character.nickname)
                        }
                        print("Data from network")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
        }
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characetsCoreData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let character = characetsCoreData[indexPath.row]
        cell.setCoreDataCharacter(character: character)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        let character = characetsCoreData[indexPath.row]
        detailVC.configureCoreDataDetail(with: character)
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}
