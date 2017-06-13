//
//  FoodMap.swift
//  FoodRewards
//
//  Created by Steven Lee on 5/31/17.
//  Copyright © 2017 Steven Lee. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class FoodMap: UIView, MKMapViewDelegate, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    var mapView = MKMapView()
    var tableView = UITableView()
    var locationManager = CLLocationManager()
    var food = [Food]()
    var lakeCnt = 0
    init(frame:CGRect, food:[Food]) {
        super.init(frame: frame)
        self.food = food
        //self.backgroundColor = .orange
        mapView = MKMapView(frame: frame)
        mapView.delegate = self
        self.mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        locationManager.delegate = self
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            //locationManager.allowsBackgroundLocationUpdates = true
            locationManager.startUpdatingLocation()
            
        }
        
        addFoodPins()
        self.addSubview(mapView)
        
//        let backBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//        backBtn.backgroundColor = .black
//        backBtn.addTarget(self, action: #selector(backButton), for: .touchUpInside)
//        self.addSubview(backBtn)
        
        tableView = UITableView(frame: CGRect(x: self.frame.width-self.frame.width/3, y: 0, width: self.frame.width/3, height: self.frame.height))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.shadowColor = UIColor.black.cgColor
        tableView.layer.shadowOpacity = 1
        tableView.layer.shadowOffset = CGSize.zero
        tableView.layer.shadowRadius = 10
        tableView.layer.shadowPath = UIBezierPath(rect: tableView.bounds).cgPath
        let head = UITableViewHeaderFooterView(frame: CGRect(x: self.frame.width-self.frame.width/3, y: 0, width: self.frame.width/3, height: 50))
        head.textLabel?.text = "F O O D"
        head.textLabel?.textAlignment = .center
        tableView.tableHeaderView = head
        self.addSubview(tableView)
        tableView.isHidden = true
        
        
//        let tableBtn = UIButton(frame: CGRect(x: self.frame.width-50, y: 0, width: 50, height: 50))
//        tableBtn.backgroundColor = .black
//        tableBtn.addTarget(self, action: #selector(showTable), for: .touchUpInside)
//        self.addSubview(tableBtn)
        
        
        
        
        let location = locationManager.location?.coordinate
        let center = CLLocationCoordinate2D(latitude: location!.latitude, longitude: location!.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04))
        
        //print(center)
        self.mapView.setRegion(region, animated: false)
        self.locationManager.stopUpdatingLocation()
    }
    
    func showTable(){
        if tableView.isHidden {
            tableView.isHidden = false
            mapView.frame = CGRect(x: -self.frame.width/3, y: 0, width: self.frame.width, height: self.frame.height)
        } else {
            tableView.isHidden = true
            mapView.frame = self.frame
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return food.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = food[indexPath.row].name
        let temp = (stepz * 0.045)
        if (food[indexPath.row].cal < temp){
             cell.accessoryType = .checkmark
        }
        return cell
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = getRandColor()
        renderer.lineWidth = 4.0
        
        return renderer
    }
    
    func getRandColor() -> UIColor {
        let dice = arc4random_uniform(10)
        
        if(dice == 0){
            return UIColor(red:0.65, green:0.95, blue:0.91, alpha:1.0)
        } else if(dice == 1){
            return UIColor(red:1.00, green:0.87, blue:0.87, alpha:1.0)
        } else if(dice == 2){
            return UIColor(red:0.80, green:0.66, blue:0.91, alpha:1.0)
        } else if(dice == 3){
            return UIColor(red:0.96, green:0.80, blue:0.43, alpha:1.0)
        } else if(dice == 4){
            return UIColor(red:0.13, green:0.78, blue:0.66, alpha:1.0)
        } else if(dice == 5){
            return UIColor(red:1.00, green:0.67, blue:0.65, alpha:1.0)
        } else if(dice == 6){
            return UIColor(red:1.00, green:0.27, blue:0.27, alpha:1.0)
        } else if(dice == 7){
            return UIColor(red:0.23, green:0.34, blue:0.49, alpha:1.0)
        } else if(dice == 8){
            return UIColor(red:0.98, green:0.95, blue:0.36, alpha:1.0)
        } else if(dice == 9){
            return UIColor(red:0.64, green:0.29, blue:0.29, alpha:1.0)
        } else {
            return UIColor(red:0.95, green:0.20, blue:0.96, alpha:1.0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func checkWater(clloc: CLLocation) -> Bool {
//        var ret = true
//        
//        CLGeocoder().reverseGeocodeLocation(clloc, completionHandler: {(placemarks, error) -> Void in
//            if error != nil {
//                //print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
//                return
//            }
//            if (placemarks?.count)! > 0 {
//                let pm = placemarks?[0]
//                if (pm?.inlandWater == nil){
//                    print("yewww")
//                    ret = false
//                } else {
//                    print("nO")
//                    ret = true
//                }
//            }
//            else {
//                //print("Problem with the data received from geocoder")
//            }
//        })
//        
//        return ret
//    }
    
    func addFoodPins(){
        for i in food {
            let temp = (stepz * 0.045)
            if (i.cal > temp){
            var meters = (stepz * 0.045) - ((i.cal / 0.045))*0.76
            meters = abs(meters)
            print("\(meters) -> \(((i.cal / 0.045))*0.76)")
            if (meters > 0){
                let coord = generateRandomCoordinates(min: UInt32(meters), max: UInt32(meters))
                let sourceLocation = locationManager.location?.coordinate
                let destinationLocation = coord
//                let clloc = CLLocation(latitude: coord.latitude, longitude: coord.longitude)
//                var ret = true
//                var cnt = 0
                
//                while(ret && cnt != 20){
//                    cnt = cnt + 1
//                
//                    coord = generateRandomCoordinates(min: UInt32(meters), max: UInt32(meters+5))
//                    destinationLocation = coord
//                    clloc = CLLocation(latitude: coord.latitude, longitude: coord.longitude)
//                    CLGeocoder().reverseGeocodeLocation(clloc, completionHandler: {(placemarks, error) -> Void in
//                        if error != nil {
//                            //print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
//                            return
//                        }
//                        if (placemarks?.count)! > 0 {
//                            let pm = placemarks?[0]
//                            if (pm?.inlandWater == nil){
//                                //print("yewww")
//                                ret = false
//                            } else {
//                                //print(pm?.inlandWater!)
//                                self.lakeCnt = self.lakeCnt + 1
//                                //print(self.lakeCnt)
//                                ret = true
//                            }
//                        }
//                        else {
//                            //print("Problem with the data received from geocoder")
//                        }
//                    })
//                }
                
                // 3.
                let sourcePlacemark = MKPlacemark(coordinate: sourceLocation!, addressDictionary: nil)
                let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
                
                // 4.
                let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
                let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
             
                let destinationAnnotation = MKPointAnnotation()
                
                destinationAnnotation.title = "\(i.name)"
                
                if let location = destinationPlacemark.location {
                    destinationAnnotation.coordinate = location.coordinate
                }
                
                // 6.
                self.mapView.showAnnotations([destinationAnnotation], animated: false )
                
                // 7.
                let directionRequest = MKDirectionsRequest()
                directionRequest.source = sourceMapItem
                directionRequest.destination = destinationMapItem
                directionRequest.transportType = .walking
                // Calculate the direction
                let directions = MKDirections(request: directionRequest)
                
                // 8.
                directions.calculate {
                    (response, error) -> Void in
                    
                    guard let response = response else {
                        if let error = error {
                            print("Error: \(error)")
                        }
                        
                        return
                    }
                    
                    let route = response.routes[0]
                    self.mapView.add((route.polyline), level: MKOverlayLevel.aboveRoads)
                    
                    let rect = route.polyline.boundingMapRect
                    self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: false)
                }
                
                
            }
        }
        }
    }
    
    func generateRandomCoordinates(min: UInt32, max: UInt32)-> CLLocationCoordinate2D {
        //Get the Current Location's longitude and latitude
        let currentLong = locationManager.location?.coordinate.longitude
        let currentLat = locationManager.location?.coordinate.latitude
        
        //1 KiloMeter = 0.00900900900901° So, 1 Meter = 0.00900900900901 / 1000
        let meterCord = 0.00900900900901 / 1000
        
        
        //then Generating Random numbers for different Methods
        let randomPM = arc4random_uniform(4)
        
        //Then we convert the distance in meters to coordinates by Multiplying number of meters with 1 Meter Coordinate
        
        //here we generate the last Coordinates
        if randomPM == 0 {
            return CLLocationCoordinate2D(latitude: currentLat! + (meterCord * Double(UInt(arc4random_uniform(max) + min))), longitude: currentLong! + (meterCord * Double(UInt(arc4random_uniform(max) + min))))
        }else if randomPM == 1 {
            return CLLocationCoordinate2D(latitude: currentLat! - (meterCord * Double(UInt(arc4random_uniform(max) + min))), longitude: currentLong! - (meterCord * Double(UInt(arc4random_uniform(max) + min))))
        }else if randomPM == 2 {
            return CLLocationCoordinate2D(latitude: currentLat! + (meterCord * Double(UInt(arc4random_uniform(max) + min))), longitude: currentLong! - (meterCord * Double(UInt(arc4random_uniform(max) + min))))
        }else{
            return CLLocationCoordinate2D(latitude: currentLat! - (meterCord * Double(UInt(arc4random_uniform(max) + min))), longitude: currentLong! + (meterCord * Double(UInt(arc4random_uniform(max) + min))))
        }
        
    }
    
    

    
    
    func backButton(){
        mapView.removeFromSuperview()
        self.removeFromSuperview()
    }
}

