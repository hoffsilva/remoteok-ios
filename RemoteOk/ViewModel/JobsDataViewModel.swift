//
//  JobsDataViewModel.swift
//  RemoteOk
//
//  Created by Hoff Henry Pereira da Silva on 03/04/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

protocol JobsDataDelegate: class {
    func loadJobDataSuccessful(array: Array<Any>)
    func loadJobDataFailed(message: String)
}

struct JobsDataViewModel {
    
    weak var delegate: JobsDataDelegate!
    
    func loadJobsFromRemoteOK() {
        Connection.fetchData { (arrayOfJobOportunities) in
            self.delegate.loadJobDataSuccessful(array: arrayOfJobOportunities as! Array<Any>)
        }
    }
    
}
