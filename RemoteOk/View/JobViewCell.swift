//
//  JobViewCell.swift
//  RemoteOk
//
//  Created by Hoff Henry Pereira da Silva on 07/04/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import UIKit

class JobViewCell: UITableViewCell {

    @IBOutlet weak var setAsFavoriteButton: UIButton!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var tagsCollectioView: UICollectionView!
    var job: Opportunity!

}


extension JobViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
//        {
//           return CGSize(width: UICollectionViewFlowLayoutAutomaticSize.width/2, height: 50.0 )
//        }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(job.tags?.count)
        return job.tags?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagCell", for: indexPath) as! TagViewCell
        if let tag = job.tags?[indexPath.row] {
            cell.tagLabel.text =  tag.uppercased()
        } else {
            cell.tagLabel.text = "none"
        }
        return cell
    }
    
    
    
}
