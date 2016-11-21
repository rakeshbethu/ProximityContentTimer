//
//  ActivityViewController.swift
//  ProximityContent
//
//  Created by Rakesh Bethu on 10/11/16.
//  Copyright © 2016 Estimote, Inc. All rights reserved.
//




import UIKit
import CloudKit

class ActivityViewController: UITableViewController {
 
    
    
    var tasks = [CKRecord]()
    var refresh:UIRefreshControl!
    var colors = [
        "FM-BL-01": UIColor(red: 255/255, green: 244/255, blue: 79/255, alpha: 1), //yellow
        "FM-BC-01": UIColor(red: 255/255, green: 186/255, blue: 210/255, alpha: 1),//pink
        "FM-BB-01": UIColor(red: 77/255, green: 47/255, blue: 51/255, alpha: 1) //brown
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "Pull to load activity")
        refresh.addTarget(self, action: "loadData", forControlEvents: .ValueChanged)
        self.tableView.addSubview(refresh)
        
        
        loadData()
    }
    
    
    func loadData () {
        tasks = [CKRecord]()
        
        let publicData = CKContainer.defaultContainer().publicCloudDatabase
       
        
        
        
    }
    

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tasks.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomCell
        
        if tasks.count == 0 {
            return cell
        }
        
        let task = tasks[indexPath.row]
        
        if let beaconName = task["BeaconName"] as? String {
           let dateString = task["StartTime"] as? String
            
            let duration = task["Time"] as? String
            cell.beaconName.text = beaconName
            cell.time.text = dateString
            cell.duration.text = duration
            //cell.colour.backgroundColor = colors[beaconName]
        }
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
