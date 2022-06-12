//
//  ProductAddViewController.swift
//  Carrot-Market
//
//  Created by 최영린 on 2022/06/06.
//

import UIKit

final class ProductAddViewController: UIViewController {

    // MARK: - @IBOutlet Properties
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var button: UIButton! {
        didSet {
            button.isEnabled = false
        }
    }
    @IBOutlet weak var priceOfferLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
    }
    
    // MARK: - @IBAction Properties
    @IBAction func cancelButtonDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func setButtonUI(_ sender: Any) {
        button.isSelected.toggle()
        button.setImage((button.isSelected) ? UIImage(named: "icn_check_on") : UIImage(named: "icn_check_after"), for: .normal)
    }
    
    @IBAction func priceEditChanged(_ sender: UITextField) {
        if sender.hasText{
            guard let price = priceTextField.text?.replacingOccurrences(of: ",", with: "") else { return }
            priceTextField.text = numberFormatter(Int(price)!)
            priceLabel.textColor = .black
            priceOfferLabel.textColor = .black
            button.isEnabled = true
            button.setImage(UIImage(named: "icn_check_after"), for: .normal)
        } else {
            priceLabel.textColor = UIColor(named: "carrot_square_gray")
            priceOfferLabel.textColor = UIColor(named: "carrot_square_gray")
            button.isEnabled = false
            button.setImage(UIImage(named: "icn_check_before"), for: .normal)
        }
    }
    
    // MARK: - Functions
    func setDelegate() {
        contentTextView.delegate = self
        titleTextField.delegate = self
    }
    
    func numberFormatter(_ number: Int)->String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(for: number)!
    }
}

extension ProductAddViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor(named: "carrot_square_gray") {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "내용을 입력해주세요."
            textView.textColor = UIColor(named: "carrot_square_gray")
        }
    }
}


