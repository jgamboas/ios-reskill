//
//  TableViewCell.swift
//  ReskillingJul22
//
//  Created by Andres Carmona Ortiz on 11/08/22.
//

import UIKit

class AnimalTableViewCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet weak var animalImageView: UIImageView!
    @IBOutlet weak var animalNameLabel: UILabel!
    @IBOutlet weak var animalTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupUI() {
        animalImageView.layer.cornerRadius = 35
    }

}
