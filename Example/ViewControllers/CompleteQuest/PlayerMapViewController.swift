//
//  PlayerMapViewController.swift
//  Example
//
//  Created by Pabel Nunez Landestoy on 5/26/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import UIKit
import MapKit

class PlayerMapViewController: UIViewController, CLLocationManagerDelegate, ARDataSource, AnnotationViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!

    fileprivate let locationManager = CLLocationManager()
    fileprivate var arViewController: ARViewController!
    var currentUserLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.showsUserLocation = true
        mapView.showsCompass = true

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            locationManager.requestWhenInUseAuthorization()
        }else{
            print("Location services are disabled, please enable before trying again.")
        }

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            let location = locations.last!
            
            currentUserLocation = location
            
            print("Accuracy: \(location.horizontalAccuracy)")
            if location.horizontalAccuracy < 100 {
                
                manager.stopUpdatingLocation()
                let span = MKCoordinateSpan(latitudeDelta: 0.014, longitudeDelta: 0.014)
                let region = MKCoordinateRegion(center: location.coordinate, span: span)
                mapView.region = region

            }else{
                print("Location accuracy is not under 100 meters, skipping...")
            }
        }else{
            print("Failed to get current location")
        }
    }

    @IBAction func completeQuest(_ sender: Any) {
        arViewController = ARViewController()

        arViewController.dataSource = self
        arViewController.maxVisibleAnnotations = 30
        arViewController.headingSmoothingFactor = 0.05
        
        // TODO: Annotation should be added after verifying user is in 10 meters around the quest location.
        let annotation = ARAnnotation()
        annotation.title = "Banano quest"
       
        annotation.location = CLLocation.init(latitude: -34.586101, longitude: -58.432100)
        arViewController.addDebugUi()
        arViewController.uiOptions.debugEnabled = true
        arViewController.maxDistance = 10
        arViewController.setAnnotations([annotation])
        
        self.present(arViewController, animated: true, completion: nil)
    }
    
    func ar(_ arViewController: ARViewController, viewForAnnotation: ARAnnotation) -> ARAnnotationView {
        let annotationView = AnnotationView()
        annotationView.annotation = viewForAnnotation
        annotationView.delegate = self
        annotationView.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        
        return annotationView
    }
    
    func didTouch(annotationView: AnnotationView) {
        print("Tapped view for POI: \(annotationView.titleLabel?.text ?? "empty value")")
    }
    
}
// MARK: - Extensions

