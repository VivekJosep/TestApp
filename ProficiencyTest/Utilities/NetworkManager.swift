//
//  NetworkManager.swift
//  ProficiencyTest
//
//  Created by mac_admin on 29/05/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static func getFacts(completion: @escaping (CountryFacts?, Error?) -> Void) {
        
        let task: URLSessionDataTask?
        
        // Validate the URL
        guard let url = URL(string: URLConstants.BaseURL + URLConstants.GetFacts) else {
            print("Bad URL")
            let err = NSError(domain: "", code: 401, userInfo: [:])
            completion(nil, err)
            return
        }
        
        // Create a default session
        let session = URLSession(configuration: .default)
         task = session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                // Handle error or no data scenario
                guard let data = data, error == nil else {
                    print("Error")
                    let err = NSError(domain: "", code: 401, userInfo: [:])
                    completion(nil, err)
                    return
                }
                
                if let  response = response as? HTTPURLResponse, response.statusCode == 200 {
                    //Convert Data to the utf8 encoding
                    if let value = String(data: data, encoding: .ascii) {
                        if let dataUTF8 = value.data(using: .utf8) {
                            do {
                                let jsonData = try JSONDecoder().decode(CountryFacts.self, from: dataUTF8)
                                completion(jsonData, nil)
                            } catch let jsonParseError {
                                completion(nil, jsonParseError)
                            }
                        }
                    }
                } else {
                    completion(nil, error)
                }
                
                 if let value = String(data: data, encoding: .ascii) {
                 if let jsonData = value.data(using: .utf8) {
                 do {
                 let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
                 print(json)
                 
                 } catch {
                 print("Unable to parse JSON")
                 }
                 }
                 }
                 
                }
        }
        task?.resume()
    }
}
