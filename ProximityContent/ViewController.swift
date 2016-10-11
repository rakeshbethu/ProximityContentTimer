//
// Please report any problems with this app template to contact@estimote.com
//

import UIKit
import CloudKit

class ViewController: UIViewController, ProximityContentManagerDelegate {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var proximityContentManager: ProximityContentManager!
    var displayTime = ""
    var time = ""
    var StartTime = ""
    var estimoteBeaconName = ""
var printString = ""
    //cloudkit
    let publicDatabase = CKContainer.defaultContainer().publicCloudDatabase
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.activityIndicator.startAnimating()

        self.proximityContentManager = ProximityContentManager(
            beaconIDs: [
                BeaconID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D", major: 32839, minor: 12703), //yellow
                BeaconID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D", major: 60981, minor: 64501), //pink
                BeaconID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D", major: 5875, minor: 20334) //beetroot
            ],
            beaconContentFactory: CachingContentFactory(beaconContentFactory: BeaconDetailsCloudFactory()))
        self.proximityContentManager.delegate = self
        self.proximityContentManager.startContentUpdates()
    }
    
    func proximityContentManager(proximityContentManager: ProximityContentManager, didUpdateContent content: AnyObject?) {
        self.activityIndicator?.stopAnimating()
        self.activityIndicator?.removeFromSuperview()
        var beaconName = ""
        var beaconName2 = ""

        if let beaconDetails = content as? BeaconDetails {
            self.view.backgroundColor = beaconDetails.backgroundColor
            beaconName2 = beaconName
            beaconName = beaconDetails.beaconName
            self.label.text = "You're in \(beaconName)'s range!"
            if(beaconName != beaconName2){
              stop()
            }
            start()
            estimoteBeaconName = beaconName
            updateTime()
            self.image.hidden = false
            
            
        } else {
            self.view.backgroundColor = BeaconDetails.neutralColor
            self.label.text = "No beacons in range."
            
            self.image.hidden = true
        }
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
//TIMER
    @IBOutlet var displayTimeLabel: UILabel!
    
  var startingTime = NSTimeInterval()
   var timer:NSTimer = NSTimer()
   
  
//function START
  func start() {
        if (!timer.valid) {
            let aSelector : Selector = #selector(ViewController.updateTime)
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
            startingTime = NSDate.timeIntervalSinceReferenceDate()
            let todaysDate:NSDate = NSDate()
            let dateFormatter:NSDateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
            let DateInFormat:String = dateFormatter.stringFromDate(todaysDate)
            StartTime = DateInFormat

        }
    }
//Function STOP
   func stop() {
    time = displayTime
    timer.invalidate()
    updateCLoudKit()

    
//    let predicate = NSPredicate(value: true)
//    let query = CKQuery(recordType: "ProximityTime", predicate: predicate)
//    var record:CKRecord = CKRecord(recordType: "ProximityTime")
//    
//    
//    publicDatabase.performQuery(query, inZoneWithID: nil) { (records, error) in
//        if(error == nil){
//            for record in records!{
//                var bName = record["BeaconName"]
//                var printStartTime = record["StartTime"]
//                var printTime = record["Time"]
//                
//                
//                print("This is \(bName),  ,\(printStartTime), ,\(printTime) ")
//            }
//            }
//        }

    }

//Func UpdateTIME
    func updateTime() {
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        //Calculate elapsed Time
        //Find the difference between current time and start time.
        var elapsedTime: NSTimeInterval = currentTime - startingTime
        
        //calculate the minutes in elapsed time.
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        //calculate the seconds in elapsed time.
        let seconds = UInt8(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)
        
        //find out the fraction of milliseconds to be displayed.
        let fraction = UInt8(elapsedTime * 100)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%02d", fraction)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        displayTimeLabel.text = "\(strMinutes):\(strSeconds):\(strFraction)"
        displayTime = "\(strMinutes):\(strSeconds):\(strFraction)"
    }
    


//function to update in cloudKit
    func updateCLoudKit(){
           let recordType = CKRecord(recordType: "ProximityTime")
        recordType["BeaconName"] = estimoteBeaconName
        recordType["StartTime"] = StartTime
        recordType["Time"] = time
//        printString += estimoteBeaconName + " " + StartTime + " " + time + " "
//        print(printString)
//        printString = ""
        publicDatabase.saveRecord(recordType) { (record, error) in
            if(error == nil){
                print("User Saved")
            } else{
                print(error?.localizedDescription)
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
