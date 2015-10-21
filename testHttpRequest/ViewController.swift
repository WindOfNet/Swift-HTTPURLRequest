//
//  ViewController.swift
//  testHttpRequest
//
//  Created by WindOfNet on 10/18/15.
//  Copyright © 2015 WindOfNet. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var txt_url: UITextField!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var txt_title: UITextField!
    @IBOutlet weak var txt_detail: UITextField!
    
    var items: NSArray = []
    
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel!.text = items[indexPath.row][self.txt_title.text!] as! String!
        cell.detailTextLabel!.text = items[indexPath.row][self.txt_detail.text!] as! String!
        
        return cell
    }
    
    @IBAction func btn_go(sender: UIButton) {
        if txt_title.text!.isEmpty || txt_detail.text!.isEmpty {
            let alert = UIAlertController(title: "Info", message: "Enter Fields!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        self.loading.startAnimating()
        
        /* ready send request */
        let url = NSURL(string: txt_url.text!)
        let request = NSMutableURLRequest(URL: url!)
        let session: NSURLSession = NSURLSession.sharedSession()
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(
            request,
            completionHandler:
            {
                //if request completion
                (data: NSData?, response: NSURLResponse?, err: NSError?) in
                
                defer {
                    self.loading.performSelectorOnMainThread(Selector("stopAnimating"), withObject: self.loading, waitUntilDone: true)
                }
                
                do {
                    if err != nil {
                        print("ERROR")
                        return
                    }
                    
                    let httpresponse = response as! NSHTTPURLResponse
                    if httpresponse.statusCode != 200 {
                        let alert = UIAlertController(title: "Error", message: "Http response: \(httpresponse.statusCode)", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
                        
                        dispatch_async(dispatch_get_main_queue(), {
                                self.presentViewController(alert, animated: true, completion: nil)
                            });

                        return;
                    }
                    
                    //parse json and assign to item: Array
                    self.items = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSArray
                    
                    self.table.performSelectorOnMainThread(Selector("reloadData"), withObject: self.table, waitUntilDone: true)
                    
                }
                catch {
                    print("ERR")
                }
        })
        
        //start task
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

