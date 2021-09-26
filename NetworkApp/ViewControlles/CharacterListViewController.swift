//
//  ViewController.swift
//  NetworkApp
//
//  Created by Слава Платонов on 24.09.2021.
//

import UIKit

class CharacterListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var characters: [BreakingBadCharacters] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestCharacets()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        detailVC.breakingBad = characters[indexPath.row]
    }
    
    private func requestCharacets() {
        guard let url = URL(string: "https://www.breakingbadapi.com/api/characters") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                print(error?.localizedDescription ?? "error not found")
                return
            }
            do {
                let json = try JSONDecoder().decode([BreakingBadCharacters].self, from: data)
                DispatchQueue.main.async {
                    self.characters = json
                    self.tableView.reloadData()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
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
        let breakingOne = characters.map { $0.name }[indexPath.row]
        let breakingTwo = characters.map { $0.nickname }[indexPath.row]
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
