//
//  Container.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-02-08.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Moya

final class Container {
    
    static func makeJobsViewModel() -> JobOppotunityViewModelAdapter {
        let viewModel = JobOportunityViewModelImpl(
            getAllJobsUseCase: makeGetAllJobsUseCase(),
            getFilteredJobsUseCase: makeGetFilteredJobsUseCase()
        )
        return JobOppotunityViewModelAdapter(jobOpportunityViewModel: viewModel)
        
    }
    
    static func makeGetAllJobsUseCase() -> GetAllJobsUseCase {
        GetAllJobsUseCaseImpl(repository: makeJobsRepository())
    }
    
    static func makeGetFilteredJobsUseCase() -> GetFilteredJobsUseCase {
        GetFilteredJobsUseCaseImpl(repository: makeJobsRepository())
    }
    
    static func makeJobsRepository() -> JobsRepository {
        JobsRespositoryImpl(datasource: makeJobsNetworkDatasource())
    }
    
    static func makeJobsNetworkDatasource() -> JobsNetworkDatasource {
        JobsNetworkDatasourceImpl(provider: MoyaProvider<JobsProvider>())
    }
    
}
