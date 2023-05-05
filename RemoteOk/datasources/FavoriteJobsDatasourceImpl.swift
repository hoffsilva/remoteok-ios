//
//  FavoriteJobsDatasourceImpl.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-04-05.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import RealmSwift

public final class LocallyJob: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var identifier: Int
    @Persisted var applyURL: String
    @Persisted var companyLogoURL: String
    @Persisted var companyName: String
    @Persisted var jobDescription: String
    @Persisted var jobTitle: String
    @Persisted var sourceLogoURL: String
    @Persisted var tags: String
}

final class FavoriteJobsDatasourceImpl: FavoriteJobsDatasource {
    
    private let realm = try? Realm()
    
    var didSaveJobWithSuccess: ((String)->Void)?
    var didSaveJobWithError: ((String)->Void)?
    
    var didDeleteJobWithSuccess: ((String)->Void)?
    var didDeletsJobWithError: ((String)->Void)?
    
    init() {}
    
    func getJobs(completion: @escaping (([JobOportunity]) -> Void)) {
        guard let realm = realm else { return }
        let locallyJobs = realm.objects(LocallyJob.self)
        completion(self.mapJobOpportunities(from: locallyJobs))
    }
    
    func saveJob(jobOportunity: JobOportunity) {
        guard let realm = realm else { return }
        try? realm.write {
            realm.add(mapLocallyJob(from: jobOportunity))
            self.didSaveJobWithSuccess?("Job added as favorite")
        }
    }
    
    func deleteJob(id: Int) {
        guard let realm = realm else { return }
        
        let locallyJobs = realm.objects(LocallyJob.self)
        
        let jobToBeDeleted = locallyJobs.where {
            $0.identifier == id
        }
        
        try? realm.write {
            realm.delete(jobToBeDeleted)
            didDeleteJobWithSuccess?("Job deleted with success!")
        }
    }
    
    private func mapJobOpportunities(from: Results<LocallyJob>) -> [JobOportunity] {
        from.map { locallyJob in
            JobOportunity(
                identifier: locallyJob.identifier,
                applyURL: locallyJob.applyURL,
                companyLogoURL: locallyJob.companyLogoURL,
                companyName: locallyJob.companyName,
                jobDescription: locallyJob.jobDescription,
                jobTitle: locallyJob.jobTitle,
                sourceLogoURL: locallyJob.sourceLogoURL,
                tags: locallyJob.tags,
                isFavorite: true
            )
        }
    }
    
    private func mapLocallyJob(from: JobOportunity) -> LocallyJob {
        LocallyJob(value: from)
    }
    
}
