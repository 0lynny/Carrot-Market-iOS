//
//  MarkerBottomSheet.swift
//  Carrot-Market
//
//  Created by 최영린 on 2022/06/30.
//

import UIKit
import NMapsMap

class MarkerBottomSheet: UIViewController {
    
    var marker: NMFMarker?
    @IBOutlet weak var bottomSheetView: UIView!
    @IBOutlet weak var bottomSheetHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first,
           touch.view == self.view {
            hideBottomSheetWithAnimation()
        }
    }
    
    private func setupUI() {
        bottomSheetHeight.constant = 0
        bottomSheetView.layer.cornerRadius = 12
        bottomSheetView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        hideBottomSheetWithAnimation()
    }
}

// MARK: - Show/Hide Animation
extension MarkerBottomSheet {
    func showBottomSheetWithAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.bottomSheetHeight.constant = 200
            self.view.layoutIfNeeded()
        }
    }
    
    func hideBottomSheetWithAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.bottomSheetHeight.constant = 0
            self.view.layoutIfNeeded()
        } completion: { _ in
            guard let marker = self.marker else { return }
            marker.width = marker.width == 70 ? 50 : 70
            marker.height = marker.height == 70 ? 50 : 70
            self.dismiss(animated: false)
        }
    }
}
