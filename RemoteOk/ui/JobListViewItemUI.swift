//
//  JobItemViewUI.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-02-08.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import SwiftUI

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
                            .frame(width: 100, height: 50)
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
