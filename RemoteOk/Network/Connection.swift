//
//  Connection.swift
//  RemoteOk
//
//  Created by Hoff Henry Pereira da Silva on 28/03/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

class Connection {
    
    static func fetchData(responseData: @escaping (Any) -> Swift.Void) {
        if !verifyConnection() {
//            let alert = FCAlertView()
//            alert.showAlert(withTitle: "Error", withSubtitle: "The internet connection has some problem", withCustomImage: nil, withDoneButtonTitle: nil, andButtons: nil)
//            alert.dismissOnOutsideTouch = true
//            alert.hideDoneButton = true
//            alert.makeAlertTypeCaution()
        }
        let stringURL = "https://remoteok.io/remote-jobs.json"
        
        let url = URL(string: stringURL)
        
        let session = URLSession.shared
        
        guard let URL = url else {
            return
        }
        
        let dataTask = session.dataTask(with: URL) { (data, response, error) in
            guard let dataOportunities = data else {
                return
            }
            
            let array = try? JSONSerialization.jsonObject(with:  dataOportunities, options: JSONSerialization.ReadingOptions.allowFragments) as! [AnyObject]
            
            guard let oportunities = array else {
                return
            }
            
            responseData(oportunities)
            
            print()
        }
        
        dataTask.resume()
        
    }
    
    static func verifyConnection() -> Bool{
        
//        if let reachabilityNetwork = Alamofire.NetworkReachabilityManager(host: "www.google.com") {
//
//            if reachabilityNetwork.isReachable {
//                return true
//            }
//        }
//
        return false
        
    }
    
    
}
