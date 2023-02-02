//
//  FoodListViewModel.swift
//  eat.before
//
//  Created by Neifmetus on 05.04.2022.
//

import Foundation
import UIKit

struct Food {
    var name: String
    var startDate: Date
    var expirationDate: Date
    var foodPicture: UIImage?
}

protocol FoodListViewModelDelegate: AnyObject {
    func updateFoodList()
    
}

class FoodListViewModel {
    var foods: [Food] = []
    var storageManager = StorageManager()
    var delegate: FoodListViewModelDelegate?
    
    var expiredProducts: [Food] {
        return foods.filter({ $0.expirationDate < Date() })
    }
    
    var allProductsExpirationDate: [Date] {
        return Set(foods.map({ $0.expirationDate })).sorted(by: { $0 < $1 })
        //TODO: без учета секунд и часов
    }
    
    func loadFood() {
        let storedFood = storageManager.allStoredFood
        storedFood.forEach {
            foods.append(Food(name: $0.name ?? "",
                              startDate: $0.startDate ?? Date(),
                              expirationDate: $0.expirationDate ?? Date(),
                              foodPicture: nil))
        }
        delegate?.updateFoodList()
    }
    
    func getFood(by date: Date) -> [Food] {
        return foods.filter({ $0.expirationDate == date })
    }
    
    func addNewFood(food: Food) {
        foods.append(food)
        storageManager.addFood(food)
    }
}
