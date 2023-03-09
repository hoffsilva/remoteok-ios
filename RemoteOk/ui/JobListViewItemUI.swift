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
        VStack(alignment: .center) {
            HStack(alignment: .center) {
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
                .padding(8)
                VStack(alignment: .center, spacing: 2) {
                    VStack(alignment: .center) {
                        Text(job.companyName)
                            .font(.system(.body))
                            .bold()
                        Text(job.jobTitle)
                            .font(.system(.title3))
                            .bold()
                    }
                }.padding(10)
                Spacer()
                AsyncImage(
                    url: URL(string: job.sourceLogoURL),
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
                .padding(8)
            }
            .tint(.primary)
            Divider()
        }
        .padding(8)
    }
}
