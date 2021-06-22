//
//  AppStoreGamesViewController.swift
//  AppStorePractice
//
//  Created by Viennarz Curtiz on 6/1/21.
//

import UIKit

class AppStoreGamesViewController: UIViewController {
	
	@IBOutlet weak var collectionView: UICollectionView!
	
	let compositionalLayoutThree = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, environment) -> NSCollectionLayoutSection? in
		var fraction: CGFloat
		
		if sectionIndex == 0 {
			fraction = 2.5 / 3.0
		} else {
			fraction = 1.0 / 3
		}
		
		
		// Item
		let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
		
		// Group
		
		let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalWidth(fraction))
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
		
		//header
		let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
		let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: "header", alignment: .top)
		headerItem.pinToVisibleBounds = true
		headerItem.zIndex = 3
		headerItem.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16)
		// Section

		let section = NSCollectionLayoutSection(group: group)
		section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
		section.orthogonalScrollingBehavior = .groupPagingCentered
		
		section.boundarySupplementaryItems = [headerItem]
		
//		let layout = UICollectionViewCompositionalLayout(section: section)
  
		
		return section
	})

    override func viewDidLoad() {
        super.viewDidLoad()

		collectionView.dataSource = self
		collectionView.delegate = self
		
		collectionView.register(UINib(nibName: "FeaturedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeaturedCollectionViewCell")
		
		collectionView.register(UINib(nibName: "GameHeaderSupplementaryView", bundle: nil), forSupplementaryViewOfKind: "header", withReuseIdentifier: "GameHeaderSupplementaryView")
		
		collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: "default", withReuseIdentifier: "collectionCell")
		
		collectionView.collectionViewLayout = compositionalLayoutThree
		collectionView.backgroundColor = .systemGray6
    }


}

extension AppStoreGamesViewController: UICollectionViewDelegate {
	
}

extension AppStoreGamesViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 6
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 2
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		return collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCollectionViewCell", for: indexPath)
	}
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		
		if kind == "header" {
			return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "GameHeaderSupplementaryView", for: indexPath)
			
		}
//		switch kind {
//
//		}
//		if indexPath.section == 1 {
//		} else {
			return UICollectionReusableView()
//		}
	}
	
	
}
