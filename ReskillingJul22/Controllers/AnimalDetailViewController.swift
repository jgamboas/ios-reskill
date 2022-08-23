//
//  AnimalDetailViewController.swift
//  ReskillingJul22
//
//  Created by Andres Carmona Ortiz on 18/08/22.
//

import UIKit

class AnimalDetailViewController: UIViewController {
    
    //MARK: Properties
    var animalImageLink: String = ""
    var animalImage: UIImage = UIImage()
    var animalName: String = ""
    var animalType: String = ""
    
    //MARK: Outlets
    @IBOutlet weak var animalImageView: UIImageView!
    @IBOutlet weak var animalNameLabel: UILabel!
    @IBOutlet weak var animalTypeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}

//MARK: Internal Methods
extension AnimalDetailViewController {
    
    private func setupUI() {
        //animalImageView.downloadedFrom(link: animalImageLink)
        animalImageView.image = animalImage
        animalImageView.layer.cornerRadius = 100
        animalNameLabel.text = animalName
        animalTypeLabel.text = animalType
    }
    
}
