//
//  StorageManager.swift
//  eat.before
//
//  Created by Екатерина Батеева on 31.07.2022.
//

import Foundation
import CoreData

class StorageManager {
    
    var allStoredFood: [StoredFood] {
        let fetchRequest: NSFetchRequest<StoredFood> = StoredFood.fetchRequest()
        do {
            let objects = try context.fetch(fetchRequest)
            return objects
        } catch {
            return []
        }
    }
    
    let persistentContainer = NSPersistentContainer(name: "FoodDataModel")
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init() {
        self.persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    func addFood(_ food: Food) {
        let storedFood = StoredFood(context: context)
        storedFood.name = food.name
        storedFood.image = food.foodPicture?.pngData()
        storedFood.startDate = food.startDate
        storedFood.expirationDate = food.expirationDate

        saveContext()
        
    }
    
    func removeFood(_ food: Food) {
        if let deletedFood = allStoredFood.first(where: { $0.name == food.name && $0.startDate == food.startDate }) {
            context.delete(deletedFood)
            saveContext()
        }
    }
    
    func saveContext() {
          if context.hasChanges {
              do {
                  try context.save()
              } catch {
                context.rollback()
                  let nserror = error as NSError
                  fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
              }
          }
      }
}
