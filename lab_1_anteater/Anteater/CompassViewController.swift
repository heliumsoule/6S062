//
//  CompassViewController.swift
//  Anteater
//
//  Created by Justin Anderson on 1/24/17.
//  Copyright © 2017 MIT. All rights reserved.
//

import UIKit
import CoreLocation

extension Double {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
    var radiansToDegrees: Double { return Double(self) * 180 / .pi }
}
extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}

class CompassViewController: UIViewController, CLLocationManagerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var anthills: [Any]? = nil
 
    let locationManager = CLLocationManager()
    var lastCoord, userCoord, targetCoord: CLLocationCoordinate2D?
    var currHeading = 0.0, lastHeading = 0.0, lastMagHeading = 0.0
    var scale: CGFloat = 0.0
    
    var antIndex:Int = 0
    
    // MARK: Outlets and Actions
    
    @IBOutlet weak var picker: UIPickerView?
    @IBOutlet weak var compass: UIImageView?
    @IBOutlet weak var needle: UIImageView?
    @IBOutlet weak var headingLabel: UILabel?
    @IBOutlet weak var distanceLabel: UILabel?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        picker?.dataSource = self
        picker?.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 0
        locationManager.headingOrientation = .portrait
        locationManager.startUpdatingHeading()
        locationManager.startUpdatingLocation()
    
        self.headingLabel?.text = ""
        self.distanceLabel?.text = ""

        AnteaterREST.fetchListOfAnthills { [weak self] (anthills) in
            DispatchQueue.main.async { [weak self] in
                self?.anthills = anthills
                self?.picker?.reloadAllComponents()
            }
        }
    }

    // MARK: - UIPickerView delegation
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return anthills?.count ?? 0
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let anthill = anthills?[row] as! [String: Any]?,
            let title = anthill["id"] as! String? else {
            return ""
        }
        return title
    }
    
    // TODO: implement me
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.antIndex = row
        
        pointNeedle()
    }
    
    // MARK: - CoreLocation
    
    // TODO: implement me
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        self.lastMagHeading = newHeading.trueHeading
        self.lastHeading = self.currHeading
        
        pointNeedle()
    }
    
    // TODO: implement me
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.lastCoord = self.userCoord
        self.userCoord = locations.last!.coordinate
        
        pointNeedle()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(status)
        print(status.rawValue)
    }

    func calculateThetaOne(lat_one: Double, lat_two: Double, lon_one: Double, lon_two: Double) -> Double {
//        atan2(sin(lon2-lon1)*cos(lat2), cos(lat1)*sin(lat2)-sin(lat1)*cos(lat2)*cos(lon2-lon1)
        
        return atan2(sin(lon_two - lon_one) * cos(lat_two),
                     cos(lat_one) * sin(lat_two) - sin(lat_one) * cos(lat_two) * cos(lon_two - lon_one))
    }
    
    func calculateDistance(lat_one: Double, lat_two: Double, lon_one: Double, lon_two: Double) -> Double {
        let r = 6371.0
        
        return 2.0 * r * asin(sqrt(sin((lat_two - lat_one) / 2.0) * sin((lat_two - lat_one) / 2.0) +
                                 cos(lat_one) * cos(lat_two) * sin((lon_two - lon_one) / 2.0) * sin((lon_two - lon_one) / 2.0)))
        
    }
    
    func pointNeedle() {
        if let coord = self.userCoord {
            if let anthills = self.anthills {
                let anthill = anthills[self.antIndex] as! [String: Any]
                let antLat = anthill["lat"] as! Double
                let antLon = anthill["lon"] as! Double
                
                let thetaOne = calculateThetaOne(lat_one: coord.latitude.degreesToRadians,
                                                 lat_two: coord.longitude.degreesToRadians,
                                                 lon_one: antLat.degreesToRadians,
                                                 lon_two: antLon.degreesToRadians)
                let distance = calculateDistance(lat_one: coord.latitude.degreesToRadians,
                                                 lat_two: coord.longitude.degreesToRadians,
                                                 lon_one: antLat.degreesToRadians,
                                                 lon_two: antLon.degreesToRadians)
                
                self.currHeading = thetaOne - self.lastMagHeading
                self.needle!.transform = CGAffineTransform(rotationAngle: CGFloat(self.currHeading))
                self.headingLabel!.text = String(format: "%.1f", self.currHeading.radiansToDegrees)
                self.distanceLabel!.text = String(format: "%.1f km", distance)
            }
        }
    }
   
}
