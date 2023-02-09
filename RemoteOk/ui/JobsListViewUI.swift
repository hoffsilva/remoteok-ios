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
    @State private var scrollToTop: (()->Void)?
    
    var body: some View {
        
        ScrollView {
            LazyVStack {
                ForEach(jobsViewModel.arrayOfJobs) { job in
                    NavigationLink {
                        JobDetailView()
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
        .searchable(text: $searchTerm, prompt: Text("Search job by name..."))
        .onSubmit(of: .search, {
            self.jobsViewModel.getFilteredOpportunities(by: searchTerm)
        })
        .navigationTitle("Abroad Jobs")
        .onAppear {
            if !jobsViewModel.viewDidLoad {
                self.jobsViewModel.getOpportunities()
                jobsViewModel.viewDidLoad = true
            }
        }
        
    }
    
}

