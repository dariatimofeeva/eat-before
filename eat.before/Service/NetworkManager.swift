//
//  NetworkManager.swift
//  eat.before
//
//  Created by Екатерина Батеева on 31.07.2022.
//

import Foundation

enum FoodError: Error {
    case urlError
    case dataError
    case responseError
}

class NetworkManager {
    let url = "https://foodish-api.herokuapp.com/api/"
    
    typealias Handler = (Result<FoodImage, FoodError>) -> Void
    
    func getRandomFood(completion: @escaping Handler) {
        guard let apiURL = URL(string: url) else {
            completion(.failure(.urlError))
            return
        }
        
        let task = URLSession.shared.dataTask(with: apiURL) { result in
            switch result {
            case .success(let data):
                do {
                    let image = try JSONDecoder().decode(FoodImage.self, from: data)
                    completion(.success(image))
                } catch {
                    completion(.failure(.dataError))
                }
            case .failure(let error):
                print(error)
                completion(.failure(.responseError))
            }
        }
        
        task.resume()
    }
}


//  let imageURL: URL = URL(string: "http://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg")!
//    let queue = DispatchQueue.global(qos: .utility)
//    queue.async{
//        if let data = try? Data(contentsOf: imageURL){
//            DispatchQueue.main.async {
//                image.image = UIImage(data: data)
//                 print("Show image data")
//            }
//            print("Did download  image data")
//        }
//    }

