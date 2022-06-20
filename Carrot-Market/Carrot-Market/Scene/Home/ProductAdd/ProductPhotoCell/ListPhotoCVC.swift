//
//  ListPhotoCVC.swift
//  Carrot-Market
//
//  Created by 최영린 on 2022/06/20.
//
import UIKit

protocol ListPhotoCVCDelegate: AnyObject {
  func didPressDeleteBtn(at index: Int)
}

final class ListPhotoCVC: UICollectionViewCell {
  
  static let identifier = "ListPhotoCVC"
  weak var delegate: ListPhotoCVCDelegate?
  var indexPath: Int = 0
      
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var deleteButton: UIButton!
  
  override func awakeFromNib() {
      super.awakeFromNib()
  }
  
  @IBAction func deleteBtnDidTap(_ sender: Any) {
      delegate?.didPressDeleteBtn(at: indexPath)
  }
}
