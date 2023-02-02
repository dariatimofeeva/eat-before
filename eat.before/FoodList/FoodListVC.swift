//
//  TableVC.swift
//  eat.before
//
//  Created by Дарья Тимофеева on 30.03.2022.
//

import UIKit
import CoreData

class FoodListVC: UIViewController, UITableViewDelegate, UITableViewDataSource, FoodListViewModelDelegate {
    func updateFoodList() {
        tableView.reloadData()
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var food: Food?
    var viewModel = FoodListViewModel()
    var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.loadFood()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "customCell")
        tableView.register(SpoiledFoodTableViewCell.self, forCellReuseIdentifier: "spoiledFoodCustomCell")
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let date = viewModel.allProductsExpirationDate[section]
        return viewModel.getFood(by: date).count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.allProductsExpirationDate.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
        return viewModel.allProductsExpirationDate[section].format() ?? ""
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell {
                let foodLabelText = cell.getTitle()
                viewModel.foods.removeAll(where: { $0.name == foodLabelText })
            }
            if let cell = tableView.cellForRow(at: indexPath) as? SpoiledFoodTableViewCell {
                let foodLabelText = cell.getTitle()
                viewModel.foods.removeAll(where: { $0.name == foodLabelText })
            }
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentDate = Date()
        let date = viewModel.allProductsExpirationDate[indexPath.section]
        if date < currentDate {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "spoiledFoodCustomCell", for: indexPath) as? SpoiledFoodTableViewCell {
                let food = viewModel.getFood(by: date)[indexPath.row]
                cell.configure(text: food.name, uiImage: food.foodPicture)
                if food.foodPicture == UIImage(systemName: "camera") {
                    //TODO: ПОЛУЧИТЬ КАРТИНКУ ИЗ API
                    networkManager.getRandomFood { result in
                        switch result {
                        case .success(let foodImage):
                            DispatchQueue.main.async {
                                let image = UIImage.getImageByUrl(foodImage.image)
                                cell.configure(text: food.name, uiImage: image)
                            }
                        default:
                            break
                        }
                    }
                }
                
                return cell
            }
        }
        if let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomTableViewCell {
            let food = viewModel.getFood(by: date)[indexPath.row]
            let image = food.foodPicture != nil ? food.foodPicture : UIImage(named: "food-default")
            cell.configure(text: food.name, uiImage: image)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    @IBAction func addFoodButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        if let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC {
            homeVC.delegate = self
            present(homeVC, animated: true)
        }
    }
}

extension FoodListVC: HomeVCDelegate {
    func recieved(food: Food) {
        viewModel.addNewFood(food: food)
        tableView.reloadData()
    }

    
}



