//
//  CollectionViewController.swift
//  RemoteOk
//
//  Created by Hoff Henry Pereira da Silva on 09/04/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import UIKit

struct RemoteFilter {
    var image: UIImage?
    var title: String?
}

class RemoteFilters: UICollectionViewController {
    
    var arrayOfFilters = [RemoteFilter]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayOfFilters = [RemoteFilter(image: UIImage(named: "remote-jobs"), title: "REMOTE JOBS"), RemoteFilter(image: UIImage(named: "dev"), title: "SOFTWARE DEVELOPMENT"), RemoteFilter(image: UIImage(named: "dev"), title: "CUSTOMER SUPPORT"), RemoteFilter(image: UIImage(named: "dev"), title: "MARKETING"), RemoteFilter(image: UIImage(named: "design"), title: "DESIGN & UX"), RemoteFilter(image: UIImage(named: "non-tech"), title: "NON-TECH"), RemoteFilter(image: UIImage(named: "english"), title: "ENGLISH TEACHER")]
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return arrayOfFilters.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "remoteFilterCell", for: indexPath) as! RemoteFilterCell
    
        if let image = arrayOfFilters[indexPath.row].image {
            cell.filterImageView.image = image
        }
        
        if let title = arrayOfFilters[indexPath.row].title {
            cell.filterTitle.text = title
        }
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

}
