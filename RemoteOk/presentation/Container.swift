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
        return JobOppotunityViewModelAdapter(
                     jobOpportunityViewModel: viewModel
            )
        
    }
    
    static func makeGetAllJobsUseCase() -> GetAllJobsUseCase {
        GetAllJobsUseCaseImpl(repository: makeJobsRepository())
    }
    
    static func makeGetFavoriteJobsUseCase() -> GetFavoritesJobsUseCase {
        GetFavoritesJobsUseCaseImpl(repository: makeFavoriteJobsRepository())
    }
    
    static func makeFavoriteJobsRepository() -> FavoriteJobsRepository {
        FavoriteJobsRepositoryImpl(datasource: makeFavoriteJobsDataSource())
    }
    
    static func makeFavoriteJobsDataSource() -> FavoriteJobsDatasource {
        FavoriteJobsDatasourceImpl()
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
    
    static func makePushNotificationManager() -> PushNotificationManager {
        PushNotificationManager(persistenceManager: makePersistenceManager())
    }
    
    static func makePersistenceManager() -> PersistenceManager {
        PersistenceManager()
    }
    
    static func makeFCMTokenRepository() -> FCMTokenRepository {
        FCMTokenRepositoryImpl(datasource: makeFCMTokenDatasource())
    }
    
    static func makeFCMTokenDatasource() -> FCMTokenNetworkDatasource {
        FCMTokenNetworkDatasourceImpl(provider: MoyaProvider<FCMTokenProvider>())
    }
    
    static func makeSaveFCMTokenUseCase() -> PostFCMTokenUseCase {
        PostFCMTokenUseCaseImpl(repository: makeFCMTokenRepository())
    }
    
    static func makeFavoriteJobsViewModel() -> FavoriteJobOppotunityViewModelAdapter {
        let viewModel = FavoriteJobOpportunityViewModelImpl(getFavoriteJobsUseCase: makeGetFavoriteJobsUseCase())
        return FavoriteJobOppotunityViewModelAdapter(favoriteJobOpportunityViewModel: viewModel)
    }
    
}
