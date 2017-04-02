//
//  SensorModel.swift
//  Anteater
//
//  Created by Justin Anderson on 8/1/16.
//  Copyright © 2016 MIT. All rights reserved.
//

import Foundation
import UIKit
import CoreBluetooth

protocol SensorModelDelegate {
    func sensorModel(_ model: SensorModel, didChangeActiveHill hill: Hill?)
    func sensorModel(_ model: SensorModel, didReceiveReadings readings: [Reading], forHill hill: Hill?)
}

extension Notification.Name {
    public static let SensorModelActiveHillChanged = Notification.Name(rawValue: "SensorModelActiveHillChangedNotification")
    public static let SensorModelReadingsChanged = Notification.Name(rawValue: "SensorModelHillReadingsChangedNotification")
}

enum ReadingType: Int {
    case Unknown = -1
    case Humidity = 2
    case Temperature = 1
    case Error = 0
}

struct Reading {
    let type: ReadingType
    let value: Double
    let date: Date = Date()
    let sensorId: String?
    
    func toJson() -> [String: Any] {
        return [
            "value": self.value,
            "type": self.type.rawValue,
            "timestamp": self.date.timeIntervalSince1970,
            "userid": UIDevice.current.identifierForVendor?.uuidString ?? "NONE",
            "sensorid": sensorId ?? "NONE"
        ]
    }
}

extension Reading: CustomStringConvertible {
    var description: String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        guard let numberString = formatter.string(from: NSNumber(value: self.value)) else {
            print("Double \"\(value)\" couldn't be formatted by NumberFormatter")
            return "NaN"
        }
        switch type {
        case .Temperature:
            return "\(numberString)°F"
        case .Humidity:
            return "\(numberString)%"
        default:
            return "\(type)"
        }
    }
}

struct Hill {
    var readings: [Reading]
    var name: String
    
    init(name: String) {
        readings = []
        self.name = name
    }
}

extension Hill: CustomStringConvertible, Hashable, Equatable {
    var description: String {
        return name
    }
    
    var hashValue: Int {
        return name.hashValue
    }
}

func ==(lhs: Hill, rhs: Hill) -> Bool {
    return lhs.name == rhs.name
}

class SensorModel {
    
    static let kBLE_SCAN_TIMEOUT = 10000.0
    
    static let shared = SensorModel()

    var delegate: SensorModelDelegate?
    var sensorReadings: [ReadingType: [Reading]] = [.Humidity: [], .Temperature: []]
    var activeHill: Hill?
    var activePeripheral: CBPeripheral?
    
    var readingBuffer: [String] = []
    
    let ble = BLE()
    
    init() {
        ble.delegate = self
    }
    
}

extension SensorModel: BLEDelegate {
    
    func ble(didUpdateState state: BLEState) {
        if state == BLEState.poweredOn {
            _ = ble.startScanning(timeout: 1)
        }
    }
    
    func ble(didDiscoverPeripheral peripheral: CBPeripheral) {
        _ = ble.connectToPeripheral(peripheral)
    }
    
    func ble(didConnectToPeripheral peripheral: CBPeripheral) {
        self.activeHill = Hill(name: peripheral.name!)
        self.activePeripheral = peripheral
        
        self.delegate?.sensorModel(self, didChangeActiveHill: self.activeHill)
    }
    
    func ble(didDisconnectFromPeripheral peripheral: CBPeripheral) {
        if peripheral == self.activePeripheral {
            self.delegate?.sensorModel(self, didChangeActiveHill: nil)
        }
    }
    
    func ble(_ peripheral: CBPeripheral, didReceiveData data: Data?) {
        let str = String(data: data!, encoding: String.Encoding.ascii)!
        
//        let val = NSString(string: str).doubleValue
    }
    
}










