//
//  ViewController.swift
//  PositionLogger
//
//  Created by Favyen Bastani on 1/30/17.
//  Copyright © 2017 6.S062. All rights reserved.
//

import UIKit
import CoreLocation
import MessageUI

enum LocationAccuracy {
    case Cellular
    case WiFi
    case GPS
}

class ViewController: UIViewController, CLLocationManagerDelegate, MFMailComposeViewControllerDelegate {
    var locationManager:CLLocationManager? = nil
    var isRecording = false
    var logFile:FileHandle? = nil
    var alert:UIAlertController? = nil
    let DATA_FILE_NAME = "log.csv"

    // UI elements
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var accuracyControl: UISegmentedControl!
    @IBOutlet weak var recordingIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // set up the location manager
        self.locationManager = CLLocationManager()
        self.locationManager?.requestAlwaysAuthorization()
        self.locationManager?.delegate = self
        self.locationManager?.distanceFilter = kCLDistanceFilterNone
        self.locationManager?.allowsBackgroundLocationUpdates = true
        self.locationManager?.disallowDeferredLocationUpdates()

        // battery logging setup
        UIDevice.current.isBatteryMonitoringEnabled = true

        // UI setup
        self.recordingIndicator.hidesWhenStopped = true
        self.startStopButton.layer.borderWidth = 1.0
        self.startStopButton.layer.cornerRadius = 5.0

        // log file setup
        self.logFile = self.openFileForWriting()
        if self.logFile == nil {
            assert(false, "Couldn't open file for writing (" + self.getPathToLogFile() + ").")
        }
        self.logLineToDataFile("Time,Lat,Lon,Altitude,Accuracy,Heading,Speed,Battery\n")
    }

    func getPathToLogFile() -> String {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let filePath = documentsPath + "/" + DATA_FILE_NAME
        return filePath
    }

    func openFileForWriting() -> FileHandle? {
        let fileManager = FileManager.default
        let created = fileManager.createFile(atPath: self.getPathToLogFile(), contents: nil, attributes: nil)
        if !created {
            assert(false, "Failed to create file at " + self.getPathToLogFile() + ".")
        }
        return FileHandle(forWritingAtPath: self.getPathToLogFile())
    }

    func logLineToDataFile(_ line: String) {
        self.logFile?.write(line.data(using: String.Encoding.utf8)!)
        print(line)
    }

    func resetLogFile() {
        self.logFile?.closeFile()
        self.logFile = self.openFileForWriting()
        if self.logFile == nil {
            assert(false, "Couldn't open file for writing (" + self.getPathToLogFile() + ").")
        }
    }

    // TODO: implement me!
    func startRecordingLocationWithAccuracy(_ acc: LocationAccuracy) {
        // your code goes here
    }

    // TODO: implement me!
    func stopRecordingLocationWithAccuracy() {
        // your code goes here
    }

    // CLLocationManagerDelegate
    // TODO: implement me!
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // your code goes here
    }

    // UI actions
    @IBAction func hitRecordStopButton(_ sender: UIButton) {
        if(!self.isRecording) {
            self.accuracyControl.isEnabled = false
            sender.setTitle("Stop", for: UIControlState.normal)
            self.isRecording = true
            self.recordingIndicator.startAnimating()
            switch self.accuracyControl.selectedSegmentIndex {
            case 0:
                self.startRecordingLocationWithAccuracy(LocationAccuracy.Cellular)
            case 1:
                self.startRecordingLocationWithAccuracy(LocationAccuracy.WiFi)
            case 2:
                self.startRecordingLocationWithAccuracy(LocationAccuracy.GPS)
            default: ()
            }
        } else {
            self.accuracyControl.isEnabled = true
            sender.setTitle("Start", for: UIControlState.normal)
            self.isRecording = false
            self.recordingIndicator.stopAnimating()
            self.stopRecordingLocationWithAccuracy()
        }
    }

    @IBAction func hitClearButton(_ sender: UIButton) {
        self.resetLogFile()
    }

    @IBAction func emailLogFile(_ sender: UIButton) {
        if !MFMailComposeViewController.canSendMail() {
            self.alert = UIAlertController(title: "Can't send mail", message: "Please set up an email account on this phone to send mail", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction) in
                self.dismiss(animated: true, completion: nil)
            })
            self.alert?.addAction(ok)
            self.present(self.alert!, animated: true, completion: nil)
            return
        }

        let fileData = NSData(contentsOfFile: self.getPathToLogFile())
        if fileData == nil || fileData?.length == 0 {
            return
        }
        let emailTitle = "Position File"
        let messageBody = "Data from PositionLogger"
        let mc = MFMailComposeViewController()
        mc.mailComposeDelegate = self
        mc.setSubject(emailTitle)
        mc.setMessageBody(messageBody, isHTML: false)
        mc.addAttachmentData(fileData as! Data, mimeType: "text/plain", fileName: DATA_FILE_NAME)
        self.present(mc, animated: true, completion: nil)
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case MFMailComposeResult.cancelled:
            NSLog("Mail cancelled")
        case MFMailComposeResult.saved:
            NSLog("Mail saved")
        case MFMailComposeResult.sent:
            NSLog("Mail sent")
        case MFMailComposeResult.failed:
            NSLog("Mail sent failure: " + (error?.localizedDescription)!)
        }

        self.dismiss(animated: true, completion: nil)
    }
}
