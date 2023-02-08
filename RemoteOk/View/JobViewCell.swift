//
//  JobViewCell.swift
//  RemoteOk
//
//  Created by Hoff Henry Pereira da Silva on 07/04/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import UIKit

class JobViewCell: UITableViewCell {
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var positionLabel: UILabel!
    @IBOutlet var companyNameLabel: UILabel!
    @IBOutlet var fakeCompanyLogoLabel: UILabel!
    @IBOutlet var postOriginLabel: UILabel!
    
    func configCell(job: JobOportunity) {
        companyNameLabel.text = job.companyName
        positionLabel.text = job.jobTitle
        logoImageView.kf.setImage(with: URL(string: job.companyLogoURL)) { [weak self] result in
            switch result {
            case .success(let image):
                self?.logoImageView.image = image.image
                self?.fakeCompanyLogoLabel.isHidden = true
            case .failure:
                self?.fakeCompanyLogoLabel.isHidden = false
                if let fakeLogo = job.companyName.first {
                    self?.fakeCompanyLogoLabel.text = String(fakeLogo).uppercased()
                } else {
                    self?.fakeCompanyLogoLabel.text = "🏢".uppercased()
                }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        logoImageView.image = nil
        companyNameLabel.text = nil
        fakeCompanyLogoLabel.text = nil
        positionLabel.text = nil
    }
}
