//
//  TableViewController.swift
//  ReskillingJul22
//
//  Created by Andres Carmona Ortiz on 10/08/22.
//

import UIKit
import FirebaseFirestore

class AnimalsTableViewController: UIViewController {
    //MARK: Properties
    /*private var animals:[(name: String, type:String, image: String)] = [
                                                        ("León", "Mamífero", "leon.jpeg"),
                                                        ("Pez Espada", "Pez", "pez-espada.jpeg"),
                                                        ("Águila", "Ave", "aguila.jpeg"),
                                                        ("Cocodrilo","Reptil", "cocodrilo.jpeg")
                                                        ]
     */
    private var animals: [Animal] = []
    private var selectedImage: UIImage = UIImage()
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        let db = Firestore.firestore()
        db.collection("animals").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    if let name = document.data()["name"] as? String, let type = document.data()["type"] as? String, let image = document.data()["image"] as? String {
                        let animal = Animal(name: name, type: type, image: image)
                        self.animals.append(animal)
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }

    }
    
    @IBAction func cerrarSesionTapped(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "IsLoggedIn")
        self.dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "animalDetail" {
            let destination = segue.destination as! AnimalDetailViewController
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let animal = animals[indexPath.row]
                destination.animalImageLink = animal.image
                destination.animalImage = selectedImage
                destination.animalName = animal.name
                destination.animalType = animal.type
            }
        }
    }
}

// MARK: UITableViewDataSource
extension AnimalsTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AnimalTableViewCell
        
        let animal = animals[indexPath.row]
        cell.animalImageView.downloadedFrom(link: animal.image)
        cell.animalNameLabel.text = animal.name
        cell.animalTypeLabel.text = animal.type
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}

// MARK: UITableViewDelegate
extension AnimalsTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! AnimalTableViewCell
        let animalName = cell.animalNameLabel.text ?? ""
        let animalType = cell.animalTypeLabel.text ?? ""
        print("Le di tap a \(animalName) (\(animalType))")
        
        if let animalImage = cell.animalImageView.image {
            selectedImage = animalImage
        }
        
        if RCValues.sharedInstance.bool(forKey: .showAnimalDetailFeature) {
            self.performSegue(withIdentifier: "animalDetail", sender: self)
        }
        
    }
    
}
