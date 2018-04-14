//
//  Connection.swift
//  RemoteOk
//
//  Created by Hoff Henry Pereira da Silva on 28/03/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import FCAlertView
import Alamofire

class Connection {
    
    static func fetchData(url: String, responseData: @escaping (DataResponse<Any>) -> Swift.Void) {
        if !verifyConnection() {
            let alert = FCAlertView()
            alert.dismissOnOutsideTouch = true
            alert.hideDoneButton = true
            alert.makeAlertTypeWarning()
            DispatchQueue.main.async {
                alert.showAlert(withTitle: "Error", withSubtitle: "The internet connection has some problem", withCustomImage: nil, withDoneButtonTitle: nil, andButtons: nil)
            }
            return
        }
        let stringURL = url
        
        let url = URL(string: stringURL.trimmingCharacters(in: .whitespaces))
        
        guard let URL = url else {
            return
        }
        
        Alamofire.request(URL).responseJSON { (response) in
            responseData(response)
        }
        
    }
    
    static func verifyConnection() -> Bool{
        
        if let reachabilityNetwork = Alamofire.NetworkReachabilityManager(host: "www.google.com") {
            
            if reachabilityNetwork.isReachable {
                return true
            }
        }
        return false
    }
    
    
}
