//
//  JobDetailView.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-02-08.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import SwiftUI

struct JobDetailView: View {
    
    @State var job: JobOportunity!
    
    @Environment(\.openURL) var openURL
    
    var jobsViewModel: JobOppotunityViewModelAdapter!
    
    init(
        job: JobOportunity,
        jobsViewModel: JobOppotunityViewModelAdapter
    ) {
        self.job = job
        self.jobsViewModel = jobsViewModel
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .trailing) {
                HStack(spacing: 20) {
                    Spacer()
                    ShareLink(item: job.applyURL) {
                        Image(systemName: "square.and.arrow.up.circle")
                            .font(.title)
                    }
                    Button {
                        print("star.circle")
                        jobsViewModel.
                    } label: {
                        job.isFavorite ? Image(systemName: "star.circle.fill").font(.title) : Image(systemName: "star.circle")
                            .font(.title)
                    }
                    
                }
                .padding()
            }
            .padding(.top, 8)
            .padding(.horizontal, 8)
            ScrollView {
                HStack(alignment: .top) {
                    VStack(alignment: .center, spacing: 40) {
                        HStack(alignment: .top) {
                            VStack {
                                AsyncImage(
                                    url: URL(string: job.companyLogoURL),
                                    content: { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 80, height: 80)
                                    },
                                    placeholder: {
                                        ProgressView()
                                            .foregroundColor(.primary)
                                            .frame(width: 80, height: 80)
                                    }
                                )
                                .clipShape(Circle())
                                Text(job.companyName)
                            }
                            .padding(8)
                            VStack {
                                AsyncImage(
                                    url: URL(string: job.sourceLogoURL),
                                    content: { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 120, height: 120)
                                    },
                                    placeholder: {
                                        Image("no-photo")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 120, height: 120)
                                    }
                                )
                                .clipShape(Circle())
                                Text("")
                            }.padding(8)
                        }
                        Divider()
                        Text(job.jobTitle)
                            .font(.title)
                            .bold()
                        if let text = job.jobDescription.formatHTMLString() {
                            Text(text.string)
                                .font(.subheadline)
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
                                .padding(.horizontal, 8)
                                .padding(.top, 0)
                        }
                    }.padding(24)
                }
            }
            Divider()
            Link(destination: URL(string: job.applyURL)!) {
                Text("Apply")
                    .font(.title2)
                    .bold()
            }
        }
        
    }
    
}
