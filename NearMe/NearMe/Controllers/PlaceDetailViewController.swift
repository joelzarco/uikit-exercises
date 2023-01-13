//
//  PlaceDetailViewController.swift
//  NearMe
//
//  Created by Johel Zarco on 10/01/23.
//

import Foundation
import UIKit

class PlaceDetailViewController : UIViewController{
    
    let place : PlaceAnnotation
    
    lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.textColor = .label
        return label
    }()
    
    lazy var addressLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .secondaryLabel
        label.alpha = 0.4
        return label
    }()
    
    let directionsButton = UIButton()
    // did Not work .addTarget with this anon definition kind
    let callButton = UIButton()
    
//    @objc var directionsButton : UIButton = { // @obj was needed here in order to acces .addTarget()
//        var config = UIButton.Configuration.bordered()
//        let button = UIButton(configuration: config)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("Directions", for: .normal)
//        return button
//    }()
    
//    var callButton : UIButton = {
//        var config = UIButton.Configuration.bordered()
//        let button = UIButton(configuration: config)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("Call", for: .normal)
//        return button
//    }()
    
    init(place: PlaceAnnotation) {
        self.place = place
        super.init(nibName: nil, bundle: nil)
        setupUI()
        style()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func directionsButtonTapped(_ sender : UIButton){
        print("Button tapped")
        let coordinate = place.location.coordinate
        guard let url = URL(string: "http://maps.apple.com/?daddr=\(coordinate.latitude),\(coordinate.longitude)") else{ return }
        UIApplication.shared.open(url)
    }
    // careful with objc method signature (_ sender : UIButton)
    @objc func callButtonTapped(_ sender : UIButton){
        print("Call button tapped")
        guard let url = URL(string: "tel://\(place.phone.formatPhoneNumber)") else { return }
        UIApplication.shared.open(url)
    }
    
    private func style(){
        
        directionsButton.configuration = .bordered()
        directionsButton.translatesAutoresizingMaskIntoConstraints = false
        directionsButton.setTitle("Directions", for: .normal)
        
        callButton.configuration = .bordered()
        callButton.translatesAutoresizingMaskIntoConstraints = false
        callButton.setTitle("Call", for: .normal)
        
        //  objc method needs a diferent signature (_:)
        directionsButton.addTarget(self, action: #selector(directionsButtonTapped(_:)), for: .primaryActionTriggered)
        callButton.addTarget(self, action: #selector(callButtonTapped(_:)), for: .primaryActionTriggered)
    }
    
    private func setupUI(){
        
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        
        nameLabel.text = place.name
        addressLabel.text = place.address
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(addressLabel)
        
        nameLabel.widthAnchor.constraint(equalToConstant: view.bounds.width - 20).isActive = true
        // buttons arranged side by side
        let contactStackView = UIStackView()
        contactStackView.translatesAutoresizingMaskIntoConstraints = false
        contactStackView.axis = .horizontal
        contactStackView.spacing = UIStackView.spacingUseSystem
        contactStackView.alignment = .center
        
        contactStackView.addArrangedSubview(directionsButton)
        contactStackView.addArrangedSubview(callButton)
        
        stackView.addArrangedSubview(contactStackView)
        
//        directionsButton.addTarget(self, action: #selector(directionsButton(_:)), for: .primaryActionTriggered)
        
        view.addSubview(stackView)
    }
    
    
    
}
