//
//  FavoriteJobsDatasourceImpl.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-04-05.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import RealmSwift

fileprivate final class LocallyJob: Object {
    @Persisted(primaryKey: true) var identifier: Int
    @Persisted var applyURL: String
    @Persisted var companyLogoURL: String
    @Persisted var companyName: String
    @Persisted var jobDescription: String
    @Persisted var jobTitle: String
    @Persisted var sourceLogoURL: String
    @Persisted var tags: String
    
    internal init(identifier: Int, applyURL: String, companyLogoURL: String, companyName: String, jobDescription: String, jobTitle: String, sourceLogoURL: String, tags: String) {
        super.init()
        self.identifier = identifier
        self.applyURL = applyURL
        self.companyLogoURL = companyLogoURL
        self.companyName = companyName
        self.jobDescription = jobDescription
        self.jobTitle = jobTitle
        self.sourceLogoURL = sourceLogoURL
        self.tags = tags
    }
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
        LocallyJob(
            identifier: from.identifier,
            applyURL: from.applyURL,
            companyLogoURL: from.companyLogoURL,
            companyName: from.companyName,
            jobDescription: from.jobDescription,
            jobTitle: from.jobTitle,
            sourceLogoURL: from.sourceLogoURL,
            tags: from.tags
        )
    }
    
}
