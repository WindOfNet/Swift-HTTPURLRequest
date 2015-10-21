# Swift-HTTPURLRequest
Test Swift 2.0 use NSURLSessionDataTask send request and convert response data to json.

Easy practice Swift 2.0 url request to get data.

<pre>
<code>
func run() -> Void {
        /* ready send request */
        let url = NSURL(string: txt_url.text!)  // http://....
        let request = NSMutableURLRequest(URL: url!)
        let session: NSURLSession = NSURLSession.sharedSession()
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(
            request,
            completionHandler:
            {
                //if request completion
                (data: NSData?, response: NSURLResponse?, err: NSError?) in
                
                do {
                    if err != nil { ... }
                    
                    let httpresponse = response as! NSHTTPURLResponse
                    if httpresponse.statusCode != 200 { ... }
                    
                    //parse json and assign to item: Array
                    self.items = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSArray
                }
                catch { ... }
        })
        
        //start task
        task.resume()
}
</code>
</pre>
