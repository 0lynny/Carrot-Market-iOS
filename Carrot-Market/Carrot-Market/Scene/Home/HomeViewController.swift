//
//  HomeViewController.swift
//  Carrot-Market
//
//  Created by 최영린 on 2022/06/01.
//

import UIKit

class HomeViewController: UIViewController {
    
    var productList : [ProductDataModel] = []
    

    @IBOutlet weak var productListTableView: UITableView!
   
    @IBOutlet weak var productAddButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadProductListURL()
    }
    
    private func setTableView() {
        let productListNib = UINib(nibName: ProductTableViewCell.className, bundle: nil)
        productListTableView.register(productListNib, forCellReuseIdentifier: ProductTableViewCell.className)
        
        productListTableView.delegate = self
        productListTableView.dataSource = self
    }
    
    @IBAction func productAddButtonDidTap(_ sender: Any) {
        print("상품추가")
    }
    
    @IBAction func locationButtonDidTap(_ sender: Any) {
        print("지역 설정")
    }
}

extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return productList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.className, for: indexPath) as? ProductTableViewCell else { return UITableViewCell() }
        cell.setProductData(productList[indexPath.row])
        return cell
    }
}

extension HomeViewController {
    private func fetchData() {
        
    }
    
    private func loadProductListURL() {
        ProductListService.shared.loadProductListData() { networkResult in
            print(networkResult)
            switch networkResult {
            case .success(let res):
                guard let response = res as? [ProductDataModel] else { return }
                self.productList = response
                self.productListTableView.reloadData()
                print(response)
            default:
                print("데이터 불러오기 실패")
            }
        }
    }
}

