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
        NavigationView {
            ScrollViewReader { value in
                ScrollView {
                    LazyVStack {
                        ForEach(jobsViewModel.arrayOfJobs) { job in
                            JobListViewItemUI(job: job)
                        }
                    }
                }
                .toolbar(content: {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button {
                            value.scrollTo(0)
                        } label: {
                            Image(systemName: "arrow.up.doc")
                        }

                    }
                })
                .searchable(text: $searchTerm, prompt: Text("Search job by name..."))
                .onSubmit(of: .search, {
                    self.jobsViewModel.getFilteredOpportunities(by: searchTerm)
                })
                .navigationTitle("Abroad Jobs")
                .onAppear {
                    self.jobsViewModel.getOpportunities()
                }
            }
        }
    }
}
