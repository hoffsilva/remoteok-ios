//
//  FavoriteJobsListViewUI.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-04-23.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import SwiftUI
import Moya

struct FavoriteJobsListViewUI: View {
    
    @ObservedObject var favoriteJobsViewModel: FavoriteJobOppotunityViewModelAdapter
    
    @State var isDetailingJob = false
    
    init(favoriteJobsViewModel: FavoriteJobOppotunityViewModelAdapter) {
        self.favoriteJobsViewModel = favoriteJobsViewModel
    }
    
    var body: some View {
        
        LoadingView(isShowing: .constant(favoriteJobsViewModel.isLoading)) {
            ScrollView {
                LazyVStack {
                    ForEach(favoriteJobsViewModel.arrayOfJobs) { job in
                        JobItemView(job: job, isDetailingJob: self.isDetailingJob)
                            .onAppear {
                                let index = favoriteJobsViewModel.arrayOfJobs.firstIndex(of: job)
                                if index == favoriteJobsViewModel.arrayOfJobs.count - 2 {
                                    favoriteJobsViewModel.getOpportunities()
                                }
                            }
                    }
                }
            }
            .navigationTitle("Abroad Jobs")
            .onAppear {
                if !favoriteJobsViewModel.viewDidLoad {
                    self.favoriteJobsViewModel.getOpportunities()
                    favoriteJobsViewModel.viewDidLoad = true
                }
            }
        }
        
    }
    
}

