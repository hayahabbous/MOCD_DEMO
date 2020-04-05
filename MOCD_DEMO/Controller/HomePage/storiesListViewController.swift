//
//  storiesListViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 7/7/19.
//  Copyright © 2019 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import AnimatedCollectionViewLayout
import NVActivityIndicatorView



class storiesListViewController: UIViewController {
    
    
    var qDelegate: quetionnairDelegate!
    var animator: (LayoutAttributesAnimator, Bool, Int, Int)?
    @IBOutlet var collectionView: UICollectionView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = (LinearCardAttributesAnimator(), false, 1, 1)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView?.isPagingEnabled = true
        
        let layout = AnimatedCollectionViewLayout()
        layout.animator = LinearCardAttributesAnimator()
        collectionView.collectionViewLayout = layout
        layout.scrollDirection = .horizontal
        
        addCurvedNavigationBar(backgroundColor: .brown, curveRadius: 17.0, shadowColor: .lightGray, shadowRadius: 4.0, heightOffset: 0.0)
        
        collectionView.reloadData()
    }
    @IBAction func dismissView(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
extension storiesListViewController: UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    //MARK: - CollectionView
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return 8
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let label = cell.viewWithTag(1) as! UILabel
        let view = cell.viewWithTag(2)
        let imageView = cell.viewWithTag(3) as! UIImageView
        
        switch indexPath.row {
        case 0:
            label.text = "Communications skills"
            imageView.image = UIImage(named: "s1")
        case 1:
            label.text = "big movement skills "
            imageView.image = UIImage(named: "s2")
        case 2:
            label.text = "Fine movement skills"
            imageView.image = UIImage(named: "s3")
        case 3:
            label.text = "Cognitive / problem solving skills"
            imageView.image = UIImage(named: "s4")
        case 4:
            label.text = "Social skills "
            imageView.image = UIImage(named: "s5")
        case 5:
            label.text = "In general skills"
            imageView.image = UIImage(named: "s6")
        case 6:
            label.text = "Social skills "
            imageView.image = UIImage(named: "s7")
        case 7:
            label.text = "In general skills"
            imageView.image = UIImage(named: "s8")
        default:
            label.text = String(describing: indexPath.row)
        }
        
        view?.backgroundColor = .white
        view?.layer.cornerRadius = 10
        view?.layer.borderWidth = 0.5
        view?.layer.borderColor = UIColor.lightGray.cgColor
        view?.layer.masksToBounds = true
        cell.addShadow(offset: CGSize(width: 0, height: 1), color: .lightGray, radius: 10, opacity: 0.9)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toReadStory", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let animator = animator else { return view.bounds.size }
        return CGSize(width: collectionView.bounds.width - 50 , height: collectionView.bounds.width - 50 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
