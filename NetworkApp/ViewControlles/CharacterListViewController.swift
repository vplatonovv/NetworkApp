//
//  ViewController.swift
//  NetworkApp
//
//  Created by Слава Платонов on 24.09.2021.
//

import UIKit

class CharacterListViewController: UIViewController {
    
    var characters: [BreakingBadCharacters] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        detailVC.breakingBad = characters[indexPath.row]
    }
    
}

extension CharacterListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let list = characters.map { $0.name }
        let secondList = characters.map { $0.nickname }
        let breakingOne = list[indexPath.row]
        let breakingTwo = secondList[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = breakingOne
        content.secondaryText = breakingTwo
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
