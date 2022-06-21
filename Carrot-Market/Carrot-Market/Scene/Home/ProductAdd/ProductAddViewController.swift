//
//  ProductAddViewController.swift
//  Carrot-Market
//
//  Created by 최영린 on 2022/06/06.
//

import UIKit
import BSImagePicker

enum Cell : Int {
    case addCell = 0, photoCell
}

final class ProductAddViewController: UIViewController {

    // MARK: - @IBOutlet Properties
    private var photoModel: PhotoDataModel = PhotoDataModel() {
        didSet{
            photoCollectionView.reloadData()
        }
    }
    @IBOutlet weak var photoCollectionView: UICollectionView!
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
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func setButtonUI(_ sender: Any) {
        button.isSelected.toggle()
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
    
    func setDelegate() {
        contentTextView.delegate = self
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
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

extension ProductAddViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoModel.userSelectedImages.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let addPhotoIdentifier = AddPhotoCVC.identifier
        let listPhotoIdentifer = ListPhotoCVC.identifier

        switch indexPath.item {
        case Cell.addCell.rawValue:
            guard let addPhotoCell = collectionView.dequeueReusableCell(withReuseIdentifier: addPhotoIdentifier, for: indexPath) as? AddPhotoCVC else { fatalError("Failed to dequeue cell for AddPhotoCVC") }
            addPhotoCell.delegate = self
            addPhotoCell.countLabel.textColor =  photoModel.userSelectedImages.count == 0 ? UIColor(named: "carrot_linegray") : UIColor(named: "carrot_text_orange")
            addPhotoCell.countLabel.text = "\(photoModel.userSelectedImages.count)"
            return addPhotoCell
        default:
            guard let listPhotoCell = collectionView.dequeueReusableCell(withReuseIdentifier: listPhotoIdentifer, for: indexPath) as? ListPhotoCVC else { fatalError("Failed to dequeue cell for ListPhotoCVC") }
            listPhotoCell.delegate = self
            listPhotoCell.indexPath = indexPath.item
        
            if photoModel.userSelectedImages.count > 0 {
                listPhotoCell.photoImageView.image = photoModel.userSelectedImages[indexPath.item - 1]
            }
            return listPhotoCell
        }
    }
}

extension ProductAddViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

extension ProductAddViewController: AddImageDelegate {
    func didPickImagesToUpload(images: [UIImage]) {
        photoModel.userSelectedImages = images
    }
}

extension ProductAddViewController: ListPhotoCVCDelegate {
    func didPressDeleteBtn(at index: Int) {
        photoModel.userSelectedImages.remove(at: index - 1)
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


