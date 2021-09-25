//
//  DetailViewController.swift
//  NetworkApp
//
//  Created by Слава Платонов on 25.09.2021.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    
    var breakingBad: BreakingBadCharacters!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
        configureUI()
        indicator()
    }
    
    private func indicator() {
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    private func configureUI() {
        nameLabel.text = breakingBad.name
        descriptionLabel.text = """
Name: \(breakingBad.name)
Nickname: \(breakingBad.nickname)
Birthday: \(breakingBad.birthday)
Status: \(breakingBad.status)
"""
    }
    
    private func fetchImage() {
        guard let url = URL(string: breakingBad.img) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            guard let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.imageView.image = image
                self.activityIndicator.stopAnimating()
            }
        }.resume()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
