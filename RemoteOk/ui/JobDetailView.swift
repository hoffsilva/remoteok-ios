//
//  JobDetailView.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-02-08.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import SwiftUI

struct JobDetailView: View {
    
    private let job: JobOportunity
    
    @Environment(\.openURL) var openURL
    
    init(job: JobOportunity) {
        self.job = job
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
                                AsyncImage(url: URL(string: job.companyLogoURL)) { content in
                                        if let image = content.image {
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 80, height: 80)
                                        } else {
                                            ProgressView()
                                                .foregroundColor(.primary)
                                                .frame(width: 80, height: 80)
                                        }
                                        
                                    }
                                .clipShape(Circle())
                                Text(job.companyName)
                            }
                            .padding(8)
                            VStack {
                                AsyncImage(url: URL(string: job.sourceLogoURL)) { content in
                                        if let image = content.image {
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 120, height: 120)
                                        } else if content.error != nil {
                                            Image(job.sourceLogoURL)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 120, height: 120)
                                        } else {
                                            ProgressView()
                                                .foregroundColor(.primary)
                                                .frame(width: 120, height: 120)
                                        }
                                        
                                    }
                                .clipShape(Circle())
                                Text("")
                            }.padding(8)
                        }
                        Divider()
                        Text(job.jobTitle ?? "")
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
