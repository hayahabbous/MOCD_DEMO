//
//  EServicesViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 6/23/19.
//  Copyright © 2019 Datacellme. All rights reserved.
//

import Foundation
import UIKit


class EServicesViewController: UIViewController {
    
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = "E-Service"
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "e_servicesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "servicesCell")
        
        
    }
}
extension EServicesViewController: UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    //MARK: - CollectionView
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cellIdentifier = "Cell"
        
        
        cellIdentifier = "servicesCell"
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! e_servicesCollectionViewCell
        
        let value = indexPath.row % 2
        switch value {
        case 0:
            cell.serviceImageView.image = UIImage(named: "new_card")
            cell.serviceLabel.text = "Issuing People of Determination Cards"
        case 1:
            cell.serviceImageView.image = UIImage(named: "renew_card")
            cell.serviceLabel.text = "Issuing Lost / damage Card for People of Determination"
        default:
            cell.serviceImageView.image = UIImage(named: "renew_card")
            cell.serviceLabel.text = "Renewing Card"
        }
        
        
        
        
        //scell.backgroundColor = .red
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: 130 , height: 130)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        
        let padding = (self.collectionView.frame.width - (130*2) - 20) / 2
        return UIEdgeInsets(top: 5, left: padding, bottom: 5, right: padding )
    }
    
}
