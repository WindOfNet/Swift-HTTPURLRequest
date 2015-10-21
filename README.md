# Swift-HTTPURLRequest
Test Swift 2.0 use NSURLSessionDataTask send request and convert response data to json.

Easy practice Swift 2.0 url request to get data.

let url = NSURL(string: txt_url.text!)
        let request = NSMutableURLRequest(URL: url!)
        let session: NSURLSession = NSURLSession.sharedSession()
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(
            request,
            completionHandler:
            {
                //if request completion
                (data: NSData?, response: NSURLResponse?, err: NSError?) in
                
                do {
                    ...
                    ...
                    //parse json and assign to item: Array
                    self.items = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSArray
                    
                }
                catch { 
                    ...
                }
        })
        //start task
        task.resume()
