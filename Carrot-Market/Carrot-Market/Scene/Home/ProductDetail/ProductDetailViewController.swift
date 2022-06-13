//
//  ProductDetailViewController.swift
//  Carrot-Market
//
//  Created by 최영린 on 2022/06/13.
//

import UIKit

class ProductDetailViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Properties
    var images = [UIImage(named: "postDetail_1"),
                  UIImage(named: "postDetail_2"),
                  UIImage(named: "postDetail_3"),
                  UIImage(named: "postDetail_4"),
                  UIImage(named: "postDetail_5")]
    var imageViews = [UIImageView]()
    var postId: String?
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        addContentScrollView()
        setPageControl()
    }
    
    // MARK: - Functions
    private func setDelegate() {
        scrollView.delegate = self
    }
    
    private func addContentScrollView() {
        
        for i in 0..<images.count {
            let imageView = UIImageView()
            let xPos = self.view.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPos, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
            imageView.image = images[i]
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
    
    // MARK: - @IBAction Properties
    @IBAction func homeButtonDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func statusButtonDidTap(_ sender: Any) {
        let actionSheet = UIAlertController(title: "상태 변경", message: nil, preferredStyle: .actionSheet)
        
        let activeAction = UIAlertAction(title: "판매중", style: .default) {_ in
            self.statusButton.titleLabel?.text = "판매중"
        }
        let reservedAction = UIAlertAction(title: "예약중", style: .default) {_ in
            self.statusButton.titleLabel?.text = "예약중"
        }
        let soldAction = UIAlertAction(title: "판매완료", style: .default) {  _ in
            self.statusButton.titleLabel?.text = "판매완료"
        }
        let cancelAction = UIAlertAction(title: "닫기", style: .cancel, handler: nil)
        
        actionSheet.addAction(activeAction)
        actionSheet.addAction(reservedAction)
        actionSheet.addAction(soldAction)
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true)
    }
    
    @IBAction func likeButtonDidTap(_ sender: UIButton) {
        likeButton.isSelected.toggle()
    }
}

