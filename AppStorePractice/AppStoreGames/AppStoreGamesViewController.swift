//
//  AppStoreGamesViewController.swift
//  AppStorePractice
//
//  Created by Viennarz Curtiz on 6/1/21.
//

import UIKit

class AppStoreGamesViewController: UIViewController {
	
	let compositionalLayoutThree: UICollectionViewCompositionalLayout = {
		let fraction: CGFloat = 1.0 / 3.0
		
		// Item
		let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
		// Group
		let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalWidth(fraction))
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
		
		// Section
		let section = NSCollectionLayoutSection(group: group)
		section.contentInsets = NSDirectionalEdgeInsets(top: 100, leading: 2.5, bottom: 0, trailing: 2.5)
		section.orthogonalScrollingBehavior = .continuous
		
		section.visibleItemsInvalidationHandler = { (items, offset, environment) in
			
			items.forEach { item in
				let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
				let minScale: CGFloat = 0.7
				let maxScale: CGFloat = 1.1
				
				let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
				item.transform = CGAffineTransform(scaleX: scale, y: scale)
				
			}
			
		}
		
		return UICollectionViewCompositionalLayout(section: section)
	}()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}
