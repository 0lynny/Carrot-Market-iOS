//
//  ProductAddViewController.swift
//  Carrot-Market
//
//  Created by 최영린 on 2022/06/06.
//

import UIKit

final class ProductAddViewController: UIViewController {

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - @IBAction Properties
    @IBAction func cancelButtonDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
