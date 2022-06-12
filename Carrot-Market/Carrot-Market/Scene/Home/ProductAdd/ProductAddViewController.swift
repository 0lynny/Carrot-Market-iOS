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
    @IBOutlet weak var bottomView: UIView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setKeyboardObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardObserver()
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
    }
    
    func numberFormatter(_ number: Int)->String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(for: number)!
    }
    
    @objc override func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            let safeareaHeight = self.view.safeAreaInsets.bottom
            UIView.animate(withDuration: 1) {
                self.bottomView.transform =
                                    CGAffineTransform(translationX: 0, y: -(keyboardHeight - safeareaHeight))
            }
        }
    }
    
    @objc override func keyboardWillHide(notification: NSNotification) {
        self.bottomView.transform = .identity
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
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            if estimatedSize.height >= 320{
                if constraint.firstAttribute == .height {
                    constraint.constant = estimatedSize.height
                }
            }
        }
    }
}


