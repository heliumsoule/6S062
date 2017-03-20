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
    
    var unfinishedReading = ""
    
    let ble = BLE()
    
    init() {
        ble.delegate = self
    }
    
}

extension SensorModel: BLEDelegate {
    
    func ble(didUpdateState state: BLEState) {
        if state == BLEState.poweredOn {
            _ = ble.startScanning(timeout: 100)
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
            _ = ble.startScanning(timeout: 100)
        }
    }
    
    func ble(_ peripheral: CBPeripheral, didReceiveData data: Data?) {
        
        // current received packet
        let packetData = String(data: data!, encoding: String.Encoding.ascii)!
        
        var start = 0
        var wasError = false
        
        // iterate through characters
        for i in 0...(packetData.characters.count-1) {
            if wasError {
                // there was previously an error, ignore it, erase previous data, move on
                self.unfinishedReading = ""
                wasError = false
            } else {
                switch packetData[packetData.index(packetData.startIndex, offsetBy: i)] {
                case "H", "T":
                    // if character is H or T, start of a new reading
                    start = i
                case "E":
                    // if character is E, there was an error. indicate it
                    wasError = true
                case "D":
                    let s = packetData.index(packetData.startIndex, offsetBy: start)
                    let t = packetData.index(packetData.startIndex, offsetBy: i)
                    
                    // currentReading is combination of whatever unfinished reading there was from previous packet,
                    // plus everything from the previous "start" index to the current index.
                    let currentReading = self.unfinishedReading + packetData.substring(with: s..<t)

                    var currentType: ReadingType
                    if currentReading[currentReading.startIndex] == "H" {
                        currentType = ReadingType.Humidity
                    } else if currentReading[currentReading.startIndex] == "T" {
                        currentType = ReadingType.Temperature
                    } else {
                        // should only reach here in case of an error/bug
                        currentType = ReadingType.Unknown
                    }
                    
                    
                    let readingValueStartIndex = currentReading.index(currentReading.startIndex, offsetBy: 1)
                    let readingValueEndIndex = currentReading.endIndex
                    let readingValue = NSString(string: currentReading.substring(with: readingValueStartIndex..<readingValueEndIndex)).doubleValue
                    
                    self.activeHill?.readings.append(Reading(type: currentType, value: readingValue, sensorId: peripheral.name))
                    
                    // recorded reading to activeHill.readings, reset and clear for next reading
                    self.unfinishedReading = ""
                    start = -1
                default:
                    break
                }
            }
        }
        if start != -1 {
            // then there must be an unfinished reading
            let s = packetData.index(packetData.startIndex, offsetBy: start)
            let t = packetData.endIndex
            self.unfinishedReading = packetData.substring(with: s..<t)
        }
        
        self.delegate?.sensorModel(self, didReceiveReadings: (self.activeHill?.readings)!, forHill: self.activeHill)
        
    }
    
}










