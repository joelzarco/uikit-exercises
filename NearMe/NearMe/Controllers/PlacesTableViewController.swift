//
//  PlacesTableViewController.swift
//  NearMe
//
//  Created by Johel Zarco on 09/01/23.
//

import Foundation
import UIKit
import MapKit

class PlacesTableViewController : UITableViewController{
    
    var userLocation : CLLocation
    let places : [PlaceAnnotation]
    
    init(userLocation: CLLocation, places: [PlaceAnnotation]) {
        self.userLocation = userLocation
        self.places = places
        super.init(nibName: nil, bundle: nil)
        // register cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PlaceCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return places.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath)
        let place = places[indexPath.row]
        // cell config
        var content = cell.defaultContentConfiguration()
        content.text = place.name
        content.secondaryText = "secondary text"
        cell.contentConfiguration = content
        
        return cell
    }
    
}
