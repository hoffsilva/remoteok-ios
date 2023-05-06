//
//  FavoriteJobsRepository.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-04-10.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

protocol FavoriteJobsRepository {
    
    var didSaveJobWithSuccess: ((String)->Void)? { get set }
    var didSaveJobWithError: ((String)->Void)? { get set }
    
    var didDeleteJobWithSuccess: ((String)->Void)? { get set }
    var didDeletsJobWithError: ((String)->Void)? { get set }
    
    func getJobs(completion: @escaping (([JobOportunity])->Void))
    func saveJob(jobOportunity: JobOportunity)
    func deleteJob(id: Int)
}
