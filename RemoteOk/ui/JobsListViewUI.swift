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
    @State var show = false
    @State var viewState = CGSize.zero
    @State var showCard = false
    @State var bottomState = CGSize.zero
    @State var showFull = false
    
    init(jobsViewModel: JobOppotunityViewModelAdapter) {
        self.jobsViewModel = jobsViewModel
    }
    
    @State private var searchTerm: String = ""
    
    var body: some View {
        
        LoadingView(isShowing: .constant(jobsViewModel.isLoading)) {
            ScrollView {
                LazyVStack {
                    ForEach(jobData) { job in
                        JobItemView(job: job)
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
            }
        }
        
    }
    
    private func loadingData() {
        self.jobsViewModel.getFilteredOpportunities(by: searchTerm)
    }
    
}

let jobData = [JobOportunity(
    applyURL: "https://apply.hire.toggl.com/9kr7z/kejdd",
    companyLogoURL: "https://ext.allremote.jobs/assets/logos/toggl5392.png",
    companyName: "Toggl",
    jobDescription: "Time zones: SBT (UTC +11), GMT (UTC +0), CET (UTC +1), EET (UTC +2), MSK (UTC +3)We are looking for an experienced Product Manager with a strong background in Saas companies to join the Toggl Hire team to shape the future of recruiting industry. Toggl Hire is the recruitment software built by Toggl and you will be responsible for introducing new features and improving existing ones in a fast-paced, product-led company.About the TeamToggl Hire is on a mission to revolutionize the way hiring happens. We are big believers that modern-day recruiting should be effortless and enjoyable. That means no more resumes or cover letters, no more endless hours screening through applications, no more interpreting past roles into current experience, no more bias and gut feeling, but informed decisions based on data.We are a fully remote team, with 18 people working from 11 different countries around Europe. We are highly skilled, highly motivated, and most importantly, a fun, friendly bunch. We value transparency,",
    jobTitle: "Remote Product Manager",
    sourceLogoURL: "https://remoteok.com/cdn-cgi/image/format=auto,fit=contain,width=100,height=100,quality=85/https://remoteok.com/assets/logo-square.png?1633381266",
    tags: "tags"
),
               JobOportunity(
                                   applyURL: "https://apply.hire.toggl.com/9kr7z/kejdd",
                                   companyLogoURL: "https://ext.allremote.jobs/assets/logos/toggl5392.png",
                                   companyName: "Toggl",
                                   jobDescription: "Time zones: SBT (UTC +11), GMT (UTC +0), CET (UTC +1), EET (UTC +2), MSK (UTC +3)We are looking for an experienced Product Manager with a strong background in Saas companies to join the Toggl Hire team to shape the future of recruiting industry. Toggl Hire is the recruitment software built by Toggl and you will be responsible for introducing new features and improving existing ones in a fast-paced, product-led company.About the TeamToggl Hire is on a mission to revolutionize the way hiring happens. We are big believers that modern-day recruiting should be effortless and enjoyable. That means no more resumes or cover letters, no more endless hours screening through applications, no more interpreting past roles into current experience, no more bias and gut feeling, but informed decisions based on data.We are a fully remote team, with 18 people working from 11 different countries around Europe. We are highly skilled, highly motivated, and most importantly, a fun, friendly bunch. We value transparency,",
                                   jobTitle: "Remote Product Manager",
                                   sourceLogoURL: "https://blog.vanhack.com/wp-content/uploads/2015/10/cropped-logo_azul_op2-32x32.png",
                                   tags: "tags"
               )]

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        JobsListViewUI(jobsViewModel: JobOppotunityViewModelAdapter)
//    }
//}
