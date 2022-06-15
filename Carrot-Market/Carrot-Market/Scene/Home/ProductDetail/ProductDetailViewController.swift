//
//  ProductDetailViewController.swift
//  Carrot-Market
//
//  Created by 최영린 on 2022/06/13.
//

import UIKit
import SwiftUI

class ProductDetailViewController: UIViewController {
    
    // MARK: - Properties
    var images : [String] = []
    
//    var images = [UIImage(named: "postDetail_1"),
//                  UIImage(named: "postDetail_2"),
//                  UIImage(named: "postDetail_3"),
//                  UIImage(named: "postDetail_4"),
//                  UIImage(named: "postDetail_5")]
    
    var imageViews = [UIImageView]()
    var postId: String?
    var onSale: String = "0"
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userRegionLabel: UILabel!
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var viewLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceSuggestionLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setStatusButton()
        getProductDetail(id: postId ?? "")
    }
    
    // MARK: - Functions
    private func setDelegate() {
        scrollView.delegate = self
    }
    
    func numberFormatter(_ number: Int)->String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(for: number)!
    }
    
    func setStatusButton() {
        self.statusButton.layer.borderColor = UIColor(named: "carrot_square_gray")?.cgColor
    }
    
    func showStatusActionSheet() {
        let actionSheet = UIAlertController(title: "상태 변경", message: nil, preferredStyle: .actionSheet)
        
        let activeAction = UIAlertAction(title: "판매중", style: .default) {_ in
            self.statusButton.setTitle("판매중", for: .normal)
            self.putProductStatus(onSale: "0")
        }
        let reservedAction = UIAlertAction(title: "예약중", style: .default) {_ in
            self.statusButton.setTitle("예약중", for: .normal)
            self.putProductStatus(onSale: "1")
        }
        let soldAction = UIAlertAction(title: "판매완료", style: .default) {  _ in
            self.statusButton.setTitle("판매완료", for: .normal)
            self.putProductStatus(onSale: "2")
        }
        let cancelAction = UIAlertAction(title: "닫기", style: .cancel, handler: nil)
        
        actionSheet.addAction(activeAction)
        actionSheet.addAction(reservedAction)
        actionSheet.addAction(soldAction)
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true)
    }
    
    // MARK: - @IBAction Properties
    @IBAction func homeButtonDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func statusButtonDidTap(_ sender: Any) {
        showStatusActionSheet()
    }
    
    @IBAction func likeButtonDidTap(_ sender: UIButton) {
        likeButton.isSelected.toggle()
        putProductLike()
    }
}

extension ProductDetailViewController: UIScrollViewDelegate {
    private func addContentScrollView() {
        for i in 0..<images.count {
            let imageView = UIImageView()
            let xPos = self.view.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPos, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
            imageView.setImage(images[i])
            scrollView.addSubview(imageView)
            scrollView.contentSize.width = imageView.frame.width * CGFloat(i + 1)
        }
    }
    
    private func setPageControl() {
        pageControl.numberOfPages = images.count
    }
    
    private func setPageControlSelectedPage(currentPage:Int) {
        pageControl.currentPage = currentPage
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = scrollView.contentOffset.x/scrollView.frame.size.width
        setPageControlSelectedPage(currentPage: Int(round(value)))
    }
}

extension ProductDetailViewController {
    func getProductDetail(id: String){
        ProductDetailService.shared.getProductDetail(dataModel: ProductDetailRequestModel(id: id)){
            networkResult in
            switch networkResult {
            case .success(let res):
                guard let response = res as? ProductDetailResponseModel else { return }
                print(response)
                self.images = response.image
                self.userNameLabel.text = response.user.name
                self.userRegionLabel.text = response.user.region
                switch response.onSale{
                    case "0":
                        self.statusButton.titleLabel?.text = "판매중"
                    case "1":
                        self.statusButton.titleLabel?.text = "예약중"
                    case "2":
                        self.statusButton.titleLabel?.text = "판매완료"
                    default: break
                }
                self.titleLabel.text = response.title
                self.categoryLabel.text = response.category
                self.createdAtLabel.text = response.createdAt
                self.viewLabel.text = "조회 \(response.view)"
                self.likeButton.isSelected = response.isLiked
                self.priceLabel.text = "\(self.numberFormatter(Int(response.price)))원"
                self.priceSuggestionLabel.text = response.isPriceSuggestion ? "가격제안가능" : "가격제안불가"
                self.addContentScrollView()
                self.setPageControl()
            case .requestErr(_):
                print("requestErr")
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
    func putProductStatus(onSale: String){
        ProductStatusService.shared.putProductStatus(dataModel: ProductStatusRequestModel(id: postId ?? "", onSale: onSale)) {
            networkResult in
            print(networkResult)
            switch networkResult {
            case .success(let res):
                guard let response = res as? ProductStatusResponseModel else { return }
                print(response)
            case .requestErr(_):
                print("requestErr")
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
    func putProductLike(){
        ProductLikeService.shared.putProductLike(dataModel: ProductLikeRequestModel(id: postId ?? "")) {
            networkResult in
            print(networkResult)
            switch networkResult {
            case .success(let res):
                guard let response = res as? ProductLikeResponseModel else { return }
                print(response)
            case .requestErr(_):
                print("requestErr")
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
}

