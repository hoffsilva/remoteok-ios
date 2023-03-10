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
        ScrollView {
            HStack(alignment: .top) {
                VStack(alignment: .center, spacing: 40) {
                    HStack(alignment: .top) {
                        AsyncImage(
                            url: URL(string: job.companyLogoURL),
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
                        .padding(8)
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
                        .padding(8)
                    }
                    Divider()
                    Text(job.jobTitle)
                        .font(.title)
                        .bold()
                    Text(job.jobDescription)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                    HStack(spacing: 20) {
                        ShareLink(item: URL(string: job.applyURL)!, message: Text("https://apps.apple.com/us/app/abroad-jobs/id1373788180"))
                            .font(.title2)
                            .bold()
                        Link(destination: URL(string: job.applyURL)!) {
                            Text("Apply")
                                .font(.title2)
                                .bold()
                        }
                    }
                }.padding(24)
            }
        }
        
    }
    
}
