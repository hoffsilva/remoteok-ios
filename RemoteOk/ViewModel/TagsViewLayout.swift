//
//  TagsViewLayout.swift
//  RemoteOk
//
//  Created by Hoff Henry Pereira da Silva on 09/04/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import UIKit

class TagsViewLayout: UICollectionViewLayout {

    private var cellAttributes = [NSIndexPath: UICollectionViewLayoutAttributes]()
    private var headerAttributes = [NSIndexPath: UICollectionViewLayoutAttributes]()
    private var contentSize: CGSize?
    
    private let numberOfVisibleDays = 1
    private let headerWidth = CGFloat(80)
    private let verticalDividerWidth = CGFloat(2)
    private let horizontalDividerHeight = CGFloat(2)
    
    private var tagViewModel = [String]()
    
    
    override func prepare() {
        if (collectionView == nil) {
            return
        }
        
        // 1: Clear the cache
        cellAttributes.removeAll()
        headerAttributes.removeAll()
        
        // 2: Calculate the height of a row
        let availableHeight = collectionView!.bounds.height
            - collectionView!.contentInset.top
            - collectionView!.contentInset.bottom
            - CGFloat(numberOfVisibleDays - 1) * horizontalDividerHeight
        
        let rowHeight = availableHeight / CGFloat(numberOfVisibleDays)
        
        // 3: Calculate the width available for time entry cells
        let itemsWidth = collectionView!.bounds.width
            - collectionView!.contentInset.left
            - collectionView!.contentInset.right
            - headerWidth;
        
        var rowY: CGFloat = 0
        
        // 4: For each day
        for (tagIndex, tag) in tagViewModel.enumerated() {
            
            // 4.1: Find the Y coordinate of the row
            rowY = CGFloat(tagIndex) * (rowHeight + horizontalDividerHeight)
            
            // 4.2: Generate and store layout attributes header cell
            
            let headerIndexPath = IndexPath(item: 0, section: tagIndex)
    
            let headerCellAttributes =
                UICollectionViewLayoutAttributes(
                    forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                    with: headerIndexPath as IndexPath)
            
            headerAttributes[headerIndexPath as NSIndexPath] = headerCellAttributes
            
            headerCellAttributes.frame = CGRect(x: 0, y: rowY, width: headerWidth, height: rowHeight)
            
            // 4.3: Get the total number of hours for the day
            //let hoursInDay = day.entries.reduce(0) { (h, e) in h + e.hours }
            
            // Set the initial X position for time entry cells
            var cellX = headerWidth
            
            // 4.4: For each time entry in day
//            for (entryIndex, entry) in tag.entries.enumerate() {
//
//                // 4.4.1: Get the width of the cell
//                var cellWidth = CGFloat(Double(entry.hours) / Double(hoursInDay)) * itemsWidth
//
//                // Leave some empty space to form the vertical divider
//                cellWidth -= verticalDividerWidth
//                cellX += verticalDividerWidth
//
//                // 4.4.3: Generate and store layout attributes for the cell
//                let cellIndexPath = NSIndexPath(forItem: entryIndex, inSection: dayIndex)
//                let timeEntryCellAttributes =
//                    UICollectionViewLayoutAttributes(forCellWithIndexPath: cellIndexPath)
//
//                cellAttributes[cellIndexPath] = timeEntryCellAttributes
//
//                timeEntryCellAttributes.frame = CGRectMake(cellX, rowY, cellWidth, rowHeight)
//
//                // Update cellX to the next starting position
//                cellX += cellWidth
//            }
        }
        
        // 5: Store the complete content size
        let maxY = rowY + rowHeight
        contentSize = CGSize(width: collectionView!.bounds.width, height: maxY)
        
        print("collectionView size = \(NSStringFromCGSize(collectionView!.bounds.size))")
        print("contentSize = \(NSStringFromCGSize(contentSize!))")
    }
    
    func collectionViewContentSize() -> CGSize {
        if contentSize != nil {
            return contentSize!
        }
        return CGSize.zero
    }
    
    override func layoutAttributesForElements(in rect: CGRect) ->
        [UICollectionViewLayoutAttributes]? {
            
            var attributes = [UICollectionViewLayoutAttributes]()
            
            for attribute in headerAttributes.values {
                if attribute.frame.intersects(rect) {
                    attributes.append(attribute)
                }
            }
            
            for attribute in cellAttributes.values {
                if attribute.frame.intersects(rect) {
                    attributes.append(attribute)
                }
            }
            
            print("layoutAttributesForElementsInRect rect = \(NSStringFromCGRect(rect)), returned \(attributes.count) attributes")
            
            return attributes
            
    }
    
    func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) ->
        UICollectionViewLayoutAttributes? {
            return cellAttributes[indexPath]
    }
    
    func layoutAttributesForSupplementaryViewOfKind(
        elementKind: String,
        atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return headerAttributes[indexPath]
    }
    
}
