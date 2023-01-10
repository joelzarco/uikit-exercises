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
    var distanceInMiles : Bool
    
    init(userLocation: CLLocation, places: [PlaceAnnotation]) {
        self.userLocation = userLocation
        self.places = places
        self.distanceInMiles = false
        super.init(nibName: nil, bundle: nil)
        // register cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PlaceCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    private func calculateDistance(from firstPlace : CLLocation, to SecondPlace : CLLocation) -> CLLocationDistance{
        return firstPlace.distance(from: SecondPlace) // .distance is an existing method by CLLocation
    }
    
    private func formatDistance( distance : CLLocationDistance) -> String{
        // it looks like iOS overrides metric units :(
        // convert to miles then parse into string
//        if(distanceInMiles == false){
//            return Measurement(value: distance, unit: UnitLength.kilometers).formatted()
//        }else{
//            let meters = Measurement(value: distance, unit: UnitLength.meters)
//            return meters.converted(to: .miles).formatted()
//        }
        let kilom = Measurement(value: distance, unit: UnitLength.kilometers)
        return kilom.formatted()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath)
        let place = places[indexPath.row]
        // cell config
        var content = cell.defaultContentConfiguration()
        content.text = place.name
        content.textProperties.color = .lightText
        let dist : CLLocationDistance = calculateDistance(from: userLocation, to: place.location)
        content.secondaryText = formatDistance(distance: dist)
        cell.contentConfiguration = content
        
        return cell
    }
    
}
