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
    @ObservedObject var jobsViewModel = JobOportunityViewModelImpl(
        getAllJobsUseCase: GetAllJobsUseCaseImpl(
            repository: JobsRespositoryImpl(
                datasource: JobsNetworkDatasourceImpl(
                    provider: MoyaProvider<JobsProvider>()))),
        getFilteredJobsUseCase: GetFilteredJobsUseCaseImpl()
    )
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(jobsViewModel.arrayOfOpportunity) { job in
                    JobListViewItemUI(job: job)
                }
            }
        }
        .navigationTitle("Abroad Jobs")
        .onAppear {
            self.jobsViewModel.getOpportunities()
        }
    }
}

struct JobListViewItemUI: View {
    private var job: JobOportunity
    
    init(job: JobOportunity) {
        self.job = job
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                AsyncImage(
                    url: URL(string: job.companyLogoURL),
                    content: { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                    },
                    placeholder: {
                        Image("no-photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                    }
                )
                .clipShape(Circle())
                VStack(alignment: .leading, spacing: 2) {
                    Text(job.companyName)
                        .font(.system(.body))
                        .bold()
                    Text(job.jobTitle)
                        .font(.system(.title3))
                        .bold()
                }.padding(.top, 10)
                Spacer()
                HStack(alignment: .bottom) {
                    AsyncImage(
                        url: URL(string: job.sourceLogoURL),
                        content: { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                        },
                        placeholder: { }
                    )
                    .clipShape(Circle())
                    .frame(width: 40, height: 40)
                }
            }
            .padding([.leading, .trailing], 10)
            .padding([.top, .bottom], 5)
            Divider()
        }
    }
}

struct JobsListView_Previews: PreviewProvider {
    static var previews: some View {
        JobsListViewUI()
    }
}
