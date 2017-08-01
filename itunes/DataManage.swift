//
//  DataManage.swift
//  itunes
//
//  Created by Juan S. Landy on 31/7/17.
//
//

import Foundation

class DataManage{
    
    public class func getDataFromItunesWithSuccess(text:String, success: @escaping (_ iTunesData:Data) -> Void){
        loadDataFromURL(url: URL(string: "https://itunes.apple.com/search?media=music&term=\(text)")!) { (data, error) -> Void in
            if let data = data {
                success(data)
            }
        }
    }
    
    public class func loadDataFromURL(url: URL, completion: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        let loadDataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let _ = error {
            completion(nil, error)
        } else if let response = response as? HTTPURLResponse {
            if response.statusCode != 200 {
                let statusError = NSError(domain: "com.itunes",
                                          code: response.statusCode,
                                          userInfo: [NSLocalizedDescriptionKey: "HTTP status code has unexpected value."])
                completion(nil, statusError)
            } else {
                completion(data, nil)
            }
        }
        }
        loadDataTask.resume()
    }
    
    public class func loadImageFromURL(url: URL, completion: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        let loadDataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(nil, error)
            } else if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    let statusError = NSError(domain: "com.itunes",
                                              code: response.statusCode,
                                              userInfo: [NSLocalizedDescriptionKey: "HTTP status code has unexpected value."])
                    completion(nil, statusError)
                } else {
                    completion(data, nil)
                }
            }
        }
        loadDataTask.resume()
    }
    
}
