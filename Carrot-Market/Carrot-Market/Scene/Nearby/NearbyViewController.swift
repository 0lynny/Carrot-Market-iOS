//
//  NearbyViewController.swift
//  Carrot-Market
//
//  Created by 최영린 on 2022/06/02.
//

import UIKit
import NMapsMap
import CoreLocation

class NearbyViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: - Properties
    var locationManager = CLLocationManager()
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var mapView: NMFMapView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setdelegate()
        setMapUI()
    }
    
    // MARK: - Functions
    func setdelegate() {
        locationManager.delegate = self
        mapView.touchDelegate = self
    }
    
    func setCamera() {
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0))
        cameraUpdate.animation = .easeIn
        mapView.moveCamera(cameraUpdate)
    }
    
    func setMarker() {
        guard let customBottomSheet = self.storyboard?.instantiateViewController(withIdentifier: "MarkerBottomSheet") as? MarkerBottomSheet else { return }
        
        let marker = NMFMarker()
        marker.iconImage = NMFOverlayImage(name: "carrot_Marker")
        marker.width = 50
        marker.height = 50
        marker.position = NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0)
        marker.touchHandler = { (overlay) -> Bool in
            self.changeMarker(marker)
            customBottomSheet.modalTransitionStyle = .crossDissolve
            customBottomSheet.modalPresentationStyle = .overFullScreen
            customBottomSheet.marker = marker
            self.present(customBottomSheet, animated: false) {
                customBottomSheet.showBottomSheetWithAnimation()
            }
            return false
        }
        marker.mapView = mapView
    }
    
    func changeMarker(_ marker:NMFMarker) {
        marker.width = marker.width == 70 ? 50 : 70
        marker.height = marker.height == 70 ? 50 : 70
    }
     
    func setMapUI() {
        mapView.positionMode = .direction
        mapView.animationDuration = 0.3
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            print("위치 서비스 On 상태")
            locationManager.startUpdatingLocation()
            setCamera()
            setMarker()
        } else {
            print("위치 서비스 Off 상태")
        }
    }
}

extension NearbyViewController : NMFMapViewTouchDelegate{
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {

    }
}



