//
//  UIImage+getImageByUrl.swift
//  eat.before
//
//  Created by Екатерина Батеева on 25.09.2022.
//

import UIKit

extension UIImage {
    
    static func getImageByUrl(_ url: String) -> UIImage? {
        if let url = URL(string: url), let data = try? Data(contentsOf: url) {
            return UIImage(data: data)
        } else {
            return nil
        }
    }
    
}
