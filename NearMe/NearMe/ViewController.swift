//
//  ViewController.swift
//  NearMe
//
//  Created by Johel Zarco on 03/01/23.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
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
        return searchTextField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .systemPink
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
}

