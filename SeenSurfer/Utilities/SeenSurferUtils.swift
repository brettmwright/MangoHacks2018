//
//  SeenSurferUtils.swift
//  SeenSurfer
//
//  Created by Brett Wright on 2/4/18.
//  Copyright © 2018 brett wright. All rights reserved.
//

import Foundation
import UIKit

class SeenSurferUtils {
    static let shared = SeenSurferUtils()
    
    /// Sets an image view to an image stored at the provided url
    func set(imageView: UIImageView, withImageAtUrl url: URL) {
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print(error.debugDescription)
            } else if let data = data {
                DispatchQueue.main.async {
                    imageView.image = UIImage(data: data)
                }
            }
        }).resume()
    }
    
}
