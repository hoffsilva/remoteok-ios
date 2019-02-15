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
            DispatchQueue.main.async {
                createAlertView().showAlert(withTitle: Messages.errorInternetConnection.title,
                                withSubtitle: Messages.errorInternetConnection.description,
                                withCustomImage: nil,
                                withDoneButtonTitle: nil,
                                andButtons: nil)
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
        
        if let reachabilityNetwork = Alamofire.NetworkReachabilityManager(host: Constants.urlOfReachabilityTest) {
            
            if reachabilityNetwork.isReachable {
                return true
            }
        }
        return false
    }
    
    private static func createAlertView() -> FCAlertView {
        let alert = FCAlertView()
        alert.dismissOnOutsideTouch = true
        alert.hideDoneButton = true
        alert.makeAlertTypeWarning()
        return alert
    }
    
    
}
