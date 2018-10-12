//
//  APIConnector.swift
//  StackoverflowSearch
//
//  Created by Josue on 2018/10/12.
//  Copyright © 2018 Private. All rights reserved.
//

import Foundation

let STACKOVERFLOW_URL_API: String = "https://api.stackexchange.com/2.2/questions?pagesize=20&order=desc&sort=activity&site=stackoverflow&filter=withbody&tagged="

protocol APIConnectorDelegate: class
{
    func loadDataOnUI(data: [String: Any])
}

class APIConnector: NSObject
{
    weak var delegate:APIConnectorDelegate?
    
    func getQuestions(tags: String)
    {
        let stringurl = String(format: "%@%@", STACKOVERFLOW_URL_API, tags).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = URL(string: stringurl)
        
        if let url = urlString
        {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if error != nil
                {
                    NSLog("____________________________________________\nError: %@\n_____________________________________________\n", error.debugDescription)
                }
                else
                {
                    
                    if let usableData = data
                    {
                        if(self.delegate != nil)
                        {
                            do{
                                let json: [String : Any] = try JSONSerialization.jsonObject(with: usableData, options: []) as! [String : Any]
                                self.delegate?.loadDataOnUI(data: json)
                            }
                            catch let error as NSError
                            {
                                print("\nFailed to load: \(error.localizedDescription)\n")
                            }
                            
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
