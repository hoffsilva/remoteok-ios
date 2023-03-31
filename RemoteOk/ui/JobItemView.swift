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
    
    @State var show = false
    @State var viewState = CGSize.zero
    @State var showCard = false
    @State var bottomState = CGSize.zero
    @State var showFull = false
    
    init(job: JobOportunity) {
        self.job = job
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 8) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(job.jobTitle)
                            .foregroundColor(.primary)
                            .font(.title)
                            .fontWeight(.bold)
                        Text(job.companyName)
                            .foregroundColor(.secondary)
                            .font(.title2)
                    }
                    Spacer()
                    ZStack {
                        Color.secondary
                            .frame(width: 42, height: 42)
                            .cornerRadius(21)
                            .frame(width: 42, height: 42)
                            .padding(1)
                        AsyncImage(
                            url: URL(string: job.sourceLogoURL),
                            content: { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            },
                            placeholder: {
                                ProgressView()
                                    .foregroundColor(.primary)
                                    .frame(width: 40, height: 40)
                            }
                        )
                    }
                    .background(Color.gray.opacity(0.3))
                    .clipShape(Circle())
                    .shadow(color: .cyan.opacity(0.2), radius: 30)
                    .padding(.horizontal, 8)
                    
                }
                .offset(y: 32)
                .padding(.horizontal, 24)
                Text(job.jobDescription)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .lineLimit(3)
                    .padding(24)
                Spacer()
                Image("job-background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 300, height: 110, alignment: .top)
            }
            .padding(.vertical, 24)
            .frame(width: showCard ? UIScreen.main.bounds.width : 340, height: showCard ? UIScreen.main.bounds.height : 220)
    //        .edgesIgnoringSafeArea(.all)
            .background(Color.primary)
            .clipShape(RoundedRectangle(cornerRadius: showCard ? 30 : 20, style: .continuous))
    //        .shadow(radius: 20)
    //        .offset(x: viewState.width, y: viewState.height)
            .offset(y: showCard ? -100 : 0)
    //        .blendMode(.hardLight)
    //        .animation(<#T##animation: Animation?##Animation?#>, value: <#T##Equatable#>)
            .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
            .onTapGesture {
                showCard.toggle()
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        self.viewState = value.translation
                        self.show = true
                    }
                    .onEnded { value in
                        self.viewState = .zero
                        self.show = false
                    }
        )
        }
    }
}

struct JobItemView_Previews: PreviewProvider {
    static var previews: some View {
        JobItemView(job: JobOportunity(
                            applyURL: "https://apply.hire.toggl.com/9kr7z/kejdd",
                            companyLogoURL: "https://ext.allremote.jobs/assets/logos/toggl5392.png",
                            companyName: "Toggl",
                            jobDescription: "Time zones: SBT (UTC +11), GMT (UTC +0), CET (UTC +1), EET (UTC +2), MSK (UTC +3)We are looking for an experienced Product Manager with a strong background in Saas companies to join the Toggl Hire team to shape the future of recruiting industry. Toggl Hire is the recruitment software built by Toggl and you will be responsible for introducing new features and improving existing ones in a fast-paced, product-led company.About the TeamToggl Hire is on a mission to revolutionize the way hiring happens. We are big believers that modern-day recruiting should be effortless and enjoyable. That means no more resumes or cover letters, no more endless hours screening through applications, no more interpreting past roles into current experience, no more bias and gut feeling, but informed decisions based on data.We are a fully remote team, with 18 people working from 11 different countries around Europe. We are highly skilled, highly motivated, and most importantly, a fun, friendly bunch. We value transparency,",
                            jobTitle: "Remote Product Manager",
                            sourceLogoURL: "https://remoteok.com/cdn-cgi/image/format=auto,fit=contain,width=100,height=100,quality=85/https://remoteok.com/assets/logo-square.png?1633381266",
                            tags: "tags"
        )
        )
    }
}

let screen = UIScreen.main.bounds
