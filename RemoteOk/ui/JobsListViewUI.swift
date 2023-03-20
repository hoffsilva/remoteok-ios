//
//  JobsListView.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-02-07.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import SwiftUI
import Moya

struct JobsListViewUI: View {
    
    @ObservedObject var jobsViewModel: JobOppotunityViewModelAdapter
    
    init(jobsViewModel: JobOppotunityViewModelAdapter) {
        self.jobsViewModel = jobsViewModel
    }
    
    @State private var searchTerm: String = ""
    
    var body: some View {
        
        LoadingView(isShowing: .constant(jobsViewModel.isLoading)) {
            ScrollView {
                LazyVStack {
                    ForEach(jobsViewModel.arrayOfJobs) { job in
                        NavigationLink {
                            JobDetailView(job: job)
                        } label: {
                            JobListViewItemUI(job: job)
                                .onAppear {
                                    let index = jobsViewModel.arrayOfJobs.firstIndex(of: job)
                                    if index == jobsViewModel.arrayOfJobs.count - 2 {
                                        jobsViewModel.getOpportunities()
                                    }
                                }
                        }
                    }
                }
            }
            .refreshable {
                self.loadingData()
            }
            .searchable(text: $searchTerm, prompt: Text("Search job by name..."))
            .onSubmit(of: .search, {
                self.jobsViewModel.isLoading = true
                self.loadingData()
            })
            .navigationTitle("Abroad Jobs")
            .onAppear {
                if !jobsViewModel.viewDidLoad {
                    self.jobsViewModel.getOpportunities()
                    jobsViewModel.viewDidLoad = true
                }
                jobsViewModel.requestPushNotificationAuthorization()
            }
        }
        
    }
    
    private func loadingData() {
        self.jobsViewModel.getFilteredOpportunities(by: searchTerm)
    }
    
}

