//
//  UIImageView+.swift
//  Carrot-Market
//
//  Created by 최영린 on 2022/06/04.
//

import Foundation

import UIKit

extension UIImageView {
    func load(imgURL: String?) {
        if let imgURL = imgURL {
            let url = URL(string: imgURL)
            if url != nil {
                DispatchQueue.global().async { [weak self] in
                    if let data = try? Data(contentsOf: url!) {
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async { self?.image = image }
                        }
                    }
                }
            }
        }
    }
}

