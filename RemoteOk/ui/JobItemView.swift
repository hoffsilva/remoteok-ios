//
//  JobItemView.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-03-30.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import SwiftUI

struct JobItemView: View {
    
    private let job: JobOportunity
    @State var isDetailingJob = false
    
    init(job: JobOportunity, isDetailingJob: Bool) {
        self.job = job
        self.isDetailingJob = isDetailingJob
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 8) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(job.jobTitle)
                            .foregroundColor(.primary)
                            .font(.title2)
                            .fontWeight(.semibold)
                        Text(job.companyName)
                            .foregroundColor(.secondary)
                            .font(.title3)
                    }
                    .padding(.top, 12)
                    Spacer()
                    AsyncImage(
                        url: URL(string: job.sourceLogoURL),
                        content: { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                                .overlay(content: {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(.gray, lineWidth: 2)
                                })
                                .clipShape(Circle())
                                .padding(.top, 8)
                                .padding(.trailing, 0)
                            
                        },
                        placeholder: {
                            ProgressView()
                                .foregroundColor(.primary)
                                .frame(width: 40, height: 40)
                        }
                    )
                }
                .padding(.horizontal, 24)
                if let text = job.jobDescription.formatHTMLString() {
                    Text(text.string)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                        .padding(.horizontal, 24)
                        .padding(.top, 0)
                        .padding(.bottom, 8)
                }
            }
            .onTapGesture {
                self.isDetailingJob.toggle()
            }
            .sheet(isPresented: $isDetailingJob) {
                JobDetailView(job: job)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 220)
        .overlay(content: {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.blue.opacity(0.3), lineWidth: 1)
                .shadow(radius: 2)
        })
        .padding(.vertical, 8)
        .padding(.horizontal)
    }
}

struct JobItemView_Previews: PreviewProvider {
    static var previews: some View {
        JobItemView(job: JobOportunity(
            identifier: 123, applyURL: "https://apply.hire.toggl.com/9kr7z/kejdd",
            companyLogoURL: "https://ext.allremote.jobs/assets/logos/toggl5392.png",
            companyName: "Toggl",
            jobDescription: "Time zones: SBT (UTC +11), GMT (UTC +0), CET (UTC +1), EET (UTC +2), MSK (UTC +3)We are looking for an experienced Product Manager with a strong background in Saas companies to join the Toggl Hire team to shape the future of recruiting industry. Toggl Hire is the recruitment software built by Toggl and you will be responsible for introducing new features and improving existing ones in a fast-paced, product-led company.About the TeamToggl Hire is on a mission to revolutionize the way hiring happens. We are big believers that modern-day recruiting should be effortless and enjoyable. That means no more resumes or cover letters, no more endless hours screening through applications, no more interpreting past roles into current experience, no more bias and gut feeling, but informed decisions based on data.We are a fully remote team, with 18 people working from 11 different countries around Europe. We are highly skilled, highly motivated, and most importantly, a fun, friendly bunch. We value transparency,",
            jobTitle: "Remote Product Manager",
            sourceLogoURL: "https://remoteok.com/cdn-cgi/image/format=auto,fit=contain,width=100,height=100,quality=85/https://remoteok.com/assets/logo-square.png?1633381266",
            tags: "tags"
        ), isDetailingJob: true
        )
    }
}

let screen = UIScreen.main.bounds
