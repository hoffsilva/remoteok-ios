//
//  JobOportunityViewModel.swift
//  RemoteOk
//
//  Created by Hoff Silva on 29/03/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

protocol JobOportunityViewModel {
    
    var didLoadJobs: (() -> Void)? { get set }
    var didLoadJobsWithError: ((String) -> Void)? { get set }
    var arrayOfOpportunity: [JobOportunity]? { get set }
    
    func getOpportunities()
    func getFilteredOpportunities(by query: String)
}

class JobOportunityViewModelImpl: JobOportunityViewModel {
    
    var arrayOfOpportunity: [JobOportunity]?
    var didLoadJobs: (() -> Void)?
    var didLoadJobsWithError: ((String) -> Void)?
    var getAllJobsUseCase: GetAllJobsUseCase
    var getFilteredJobsUseCase: GetFilteredJobsUseCase
    var currentPage = 1
    var numberOfPages = 1
    
    init(getAllJobsUseCase: GetAllJobsUseCase, getFilteredJobsUseCase: GetFilteredJobsUseCase) {
        self.getAllJobsUseCase = getAllJobsUseCase
        self.getFilteredJobsUseCase = getFilteredJobsUseCase
        setupBindings()
    }

    func getOpportunities() {
        if currentPage <= numberOfPages {
            getAllJobsUseCase.getJobsOf(page: currentPage)
            self.currentPage += 1
        }
    }
    
    func getFilteredOpportunities(by query: String) {
        getFilteredJobsUseCase.searchJobsBy(query: query)
    }
    
    func setupBindings() {
        
        getAllJobsUseCase.didGetJobs = { [weak self] dataJob in
            if self?.arrayOfOpportunity == nil {
                self?.arrayOfOpportunity = dataJob.jobs
            } else {
                self?.arrayOfOpportunity! += dataJob.jobs
            }
            self?.numberOfPages = dataJob.numberOfPages
            self?.didLoadJobs?()
        }
        
        getAllJobsUseCase.didGetError = { [weak self] error in
            self?.didLoadJobsWithError?(error.localizedDescription)
        }
        
        getFilteredJobsUseCase.didGetJobs = { [weak self] jobs in
            self?.arrayOfOpportunity = jobs
            self?.didLoadJobs?()
        }
        
        getFilteredJobsUseCase.didGetError = { [weak self] error in
            self?.didLoadJobsWithError?(error.localizedDescription)
        }
        
    }

}


extension JobOportunityViewModelImpl {
    
    func jobData() -> [JobOportunity] {
        [JobOportunity(
        applyURL: "https://apply.hire.toggl.com/9kr7z/kejdd",
        companyLogoURL: "https://ext.allremote.jobs/assets/logos/toggl5392.png",
        companyName: "Toggl",
        jobDescription: "<html><body><p>Hi there,</p><p>I'm Nicolas, TestGorilla's Head of Engineering. We're a fast-growing HR tech startup that helps hiring teams make better hiring decisions faster and bias-free.</p><p>Over the past year, we've experienced tremendous growth. More than 7,500 companies have replaced CVs with our assessments to screen candidates in an unbiased and data-driven way.</p><p>As we scale our efforts in 2022 and beyond, we're looking for a <strong>Senior Frontend Engineer</strong> who's passionate about joining our quest to help people land dream jobs.</p><h2><br/></h2><h2>The Proposition</h2><ul><li>Helping shape a fast-growing HR tech startup as an early employee</li><li>Fully remote position with bright, motivated, and friendly colleagues around the world</li><li>Competitive salary incl. bonus and stock options</li><li>Flexible hours and vacation</li><li>Paid parental leave</li><li>€1000 remote working budget per year</li><li>3.5% of salary learning &amp; development budget</li></ul><p><br/></p><h2>The Role in Context</h2><ul><li>We are looking for a <strong>Senior Frontend Engineer</strong> to join our engineering department and help us bring our product to Enterprise level maturity. Your work will directly impact hundreds of thousands of users around the world.</li><li>As a senior member of the engineering team, you will build and deliver frontend solutions to provide extraordinary product experiences for our users, including SPAs and reusable components for the rapid growth of all our products.</li><li>You'll own the design, code, and deployment of solutions and make sure they perform and scale in production.</li></ul><h2>You'll spend time on the following</h2><ul><li>Take full <strong>ownership</strong> of the frontend; from low-level optimizations to improving user experience</li><li>Build <strong>reusable</strong> code and libraries for future use</li><li>Ensure the technical feasibility of UI/UX designs and propose features and functionalities to the product team</li><li><strong>Optimize</strong> the application for maximum speed and scalability</li><li>Lead the entire <strong>software development and delivery</strong> cycle from ideation to deployment and everything in between</li><li>Efficiently utilize <strong>DevOps</strong> tools and practices to deliver high-quality software as well as value to end customers as early as possible</li><li>Work in a collaborative, talented <strong>distributed team</strong> across Europe, United States, South America, and Asia</li><li>You will act as a <strong>mentor</strong> for less-experienced team members through both your technical knowledge and leadership skills</li></ul><h2>Here's what we're looking for</h2><ul><li>You are inspired by our mission to put <em>one billion people in dream jobs</em></li><li>You are fully aligned with our values</li><li>Experience designing, implementing, running, and maintaining production front-end code using modern client-side development frameworks based on JS/TS such as Angular</li><li>You strive for excellence: pixel-perfect, high-quality code, and lightning-fast load times</li><li>You care deeply about building a world-class engineering team</li><li>You have a solid understanding of UX/UI design, usability, and accessibility</li><li>You are passionate about improving skills and learning new technologies</li><li>You enjoy influencing others and always advocate for technical excellence while being open to change</li><li>You're resilient in ambiguous situations and can approach challenges from multiple perspectives</li><li>You have strong written and verbal communication skills. You can validate your decisions and communicate them clearly</li></ul><p>We typically expect candidates with at least <strong>7 years of Senior Frontend Engineer experience</strong> to have the skills mentioned above.</p><p><strong>Bonus points if ...</strong></p><ul><li>you have experience in a SaaS product based company</li><li>you are comfortable with Agile methods, such as Extreme Programming (XP), Scrum, and/or Kanban</li><li>you have a working knowledge of cloud technology such as AWS, Azure, Kubernetes, and Docker</li></ul><p><br/></p><h2>Interested?</h2><ul><li>Here at TestGorilla, we eat our own dog food. We use our assessment platform to make sure we make the best hiring decisions faster and bias-free. I took one too and I enjoyed it!</li><li>So if this role sounds like a good fit for you, I'd like you to take an assessment so we can get a better idea about whether you would fit the role. It's also a great opportunity for you to get to know our product! Simply use the Apply button.</li><li>If you're hired, I'll do everything I can to help you succeed at TestGorilla and throughout the rest of your career.</li></ul></body></html>",
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
    }
    
}
