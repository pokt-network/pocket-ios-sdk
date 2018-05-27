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
    var activeQuest: Quest?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Map settings
        mapView.showsUserLocation = true
        mapView.showsCompass = true
        
        // Location manager setup
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        
        // Checks is location services are enabled to start updating location
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
        // Location update
        if locations.count > 0 {
            let location = locations.last!
            
            currentUserLocation = location
            
            print("Accuracy: \(location.horizontalAccuracy)")
            if location.horizontalAccuracy < 100 {
                
                manager.stopUpdatingLocation()
                // span: is how much it should zoom into the user location
                let span = MKCoordinateSpan(latitudeDelta: 0.014, longitudeDelta: 0.014)
                let region = MKCoordinateRegion(center: location.coordinate, span: span)
                // updates map with current user location
                mapView.region = region

            }else{
                print("Location accuracy is not under 100 meters, skipping...")
            }
        }else{
            print("Failed to get current location")
        }
    }

    @IBAction func completeQuest(_ sender: Any) {
        // AR init
        arViewController = ARViewController()
        // AR Setup
        arViewController.dataSource = self
        arViewController.maxVisibleAnnotations = 30
        arViewController.headingSmoothingFactor = 0.05
        
        // TODO: Annotation should be added after verifying user is in 10 meters around the quest location.
        // following data is for testing
        let questLocation = CLLocation(latitude: (activeQuest?.latitude)!, longitude: (activeQuest?.longitude)!)
        let distance = questLocation.distance(from: currentUserLocation!)
        if distance <= 20 {
            let annotation = ARAnnotation()
            annotation.title = activeQuest?.name
            annotation.location = questLocation
            
            // AR options, debugging options should be used only for testing
//            arViewController.addDebugUi()
            arViewController.uiOptions.debugEnabled = false
            arViewController.maxDistance = 20
            
            // We add the annotations that for Banano quest is 1 at a time
            arViewController.setAnnotations([annotation])
            // ARvc presentation
            self.present(arViewController, animated: true, completion: nil)
        }else{
            let alertController = UIAlertController(title: "Not in range", message: "\(activeQuest?.name ?? "") quest is not within 10 meters of your current location", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
                print("You've pressed Ok");
                self.dismiss(animated: false, completion: nil)
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }

    }
    
    func ar(_ arViewController: ARViewController, viewForAnnotation: ARAnnotation) -> ARAnnotationView {
        // View for the annotation setup
        let annotationView = AnnotationView()
        annotationView.annotation = viewForAnnotation
        annotationView.delegate = self
        annotationView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        
        return annotationView
    }
    
    func didTouch(annotationView: AnnotationView) {
        // TODO: Add any wanted action to happen when annotation is tapped
        print("Tapped view for POI: \(annotationView.titleLabel?.text ?? "empty value")")
        
        let alertController = UIAlertController(title: "Success!", message: "Congratulations, quest completed.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
            print("You've pressed Ok");
            self.dismiss(animated: false, completion: nil)
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
// MARK: - Extensions

