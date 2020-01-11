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

    func configCell(jobViewModel: JobOportunityViewModel) {
        companyNameLabel.text = jobViewModel.getJob().company ?? "None"
        positionLabel.text = jobViewModel.getJob().position ?? "None"
        logoImageView.sd_addActivityIndicator()
        logoImageView.sd_setShowActivityIndicatorView(true)
        if let epoch = jobViewModel.getJob().epoch {
            postOriginLabel.text = epoch
        }
        if let imageUrl = jobViewModel.getJob().logo {
            logoImageView.sd_setImage(with: URL(string: imageUrl)) { image, _, _, _ in
                if image == nil {
                    self.fakeCompanyLogoLabel.isHidden = false
                    if let fakeLogo = jobViewModel.getJob().company?.first {
                        self.fakeCompanyLogoLabel.text = String(fakeLogo).uppercased()
                    } else {
                        self.fakeCompanyLogoLabel.text = "🏢".uppercased()
                    }
                } else {
                    self.fakeCompanyLogoLabel.isHidden = true
                }
            }
        }
    }
}
