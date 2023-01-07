//
//  ViewController.swift
//  NearMe
//
//  Created by Johel Zarco on 03/01/23.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    var locationManager : CLLocationManager?
    
    lazy var mapView : MKMapView = {
        let map = MKMapView()
        map.showsUserLocation = true
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    lazy var searchTextField : UITextField = {
        let searchTextField = UITextField()
        searchTextField.layer.cornerRadius = 10
        searchTextField.clipsToBounds = true
        searchTextField.backgroundColor = UIColor.white
        searchTextField.placeholder = "Search"
        searchTextField.leftViewMode = .always
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        // to add padding to the left inside the textField
        searchTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        searchTextField.delegate = self
        return searchTextField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .systemPink
        
        // init location manager. Don't forget to add Location -when in usage in info.plist
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization() // there is several options, and require different privacy warning in .plist
        locationManager?.requestLocation()
        setupUI()

    }

    private func setupUI(){
        view.addSubview(searchTextField)
        view.addSubview(mapView)
        // serchTextField is currently behind mapView, we solve it with
        view.bringSubviewToFront(searchTextField)
        // searchTextField
        searchTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        searchTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchTextField.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 1.2).isActive = true
        searchTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        searchTextField.returnKeyType = .go
        
        // mapView
        mapView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mapView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    private func checkLocationAuth(){
        guard let locationManager = locationManager, let location = locationManager.location else{ return }
        
        switch locationManager.authorizationStatus{
        case .authorizedAlways, .authorizedWhenInUse:
            print("Good to go")
            // focus on user's location
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
            mapView.setRegion(region, animated: true)
        case .denied:
            print("User denied access")
        case .notDetermined, .restricted:
            print("Unavailable")
        default:
            print("Something went terribly wrong")
        }
    }
    
    private func findNearbyPlaces(by query : String){
        mapView.removeAnnotations(mapView.annotations)
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, error in
            guard let response = response, error == nil else { return }
            print(response.mapItems)
            // create a map annotation from every member in the mapItemsArray
            let places = response.mapItems.map(PlaceAnnotation.init)
            // now add them to the view
            places.forEach { place in
                self?.mapView.addAnnotation(place)
            }
        }
    }
    
    
}

extension ViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let text = textField.text ?? ""
        if !text.isEmpty{
            textField.resignFirstResponder()
            // look for nearby places
            findNearbyPlaces(by: text)
        }
        return true
    }
}

extension ViewController : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuth()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}

