//
//  ViewController.swift
//  AppStorePractice
//
//  Created by Viennarz Curtiz on 5/14/21.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var collectionView: UICollectionView!
	
	let colors =  [UIColor.red, UIColor.yellow, UIColor.systemPink, UIColor.systemGreen, UIColor.systemBlue, UIColor.systemTeal, UIColor.brown, UIColor.cyan, UIColor.systemGray3, UIColor.init(displayP3Red: 0.34, green: 0.19, blue: 0.49, alpha: 1),
				   UIColor.init(displayP3Red: 0.26, green: 0.24, blue: 0.9, alpha: 1),
				   UIColor.init(displayP3Red: 0.53, green: 0.11, blue: 0.63, alpha: 1),UIColor.red, UIColor.yellow, UIColor.systemPink, UIColor.systemGreen, UIColor.systemBlue, UIColor.systemTeal, UIColor.brown, UIColor.cyan, UIColor.systemGray3,]
	
	let flowLayout: UICollectionViewFlowLayout = {
		let layout = UICollectionViewFlowLayout()
		layout.minimumInteritemSpacing = 5
		layout.minimumLineSpacing = 5
		layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
		return layout
	}()
	
	let compositionalLayout: UICollectionViewCompositionalLayout = {
		
		let inset: CGFloat = 8
		
		let widthDimension = NSCollectionLayoutDimension.fractionalWidth(1)
		let heightDimension = NSCollectionLayoutDimension.fractionalWidth(1/3)
		
		//supplementary item
		let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.1), heightDimension: .absolute(30))
		let containerAnchor = NSCollectionLayoutAnchor(edges: [.bottom], absoluteOffset: CGPoint(x: 0, y: 10))
		
		let supplementaryItem = NSCollectionLayoutSupplementaryItem(layoutSize: layoutSize, elementKind: "new-banner", containerAnchor: containerAnchor)
		
		
		//item
		let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1))
		let item = NSCollectionLayoutItem(layoutSize: itemSize, supplementaryItems: [supplementaryItem])
		item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
		
		//group
		let groupSize = NSCollectionLayoutSize(widthDimension: widthDimension, heightDimension: heightDimension)
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
		
		//header
		let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
		let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: "header", alignment: .top)
		headerItem.pinToVisibleBounds = true
		
		//section
		let section = NSCollectionLayoutSection(group: group)
		
		// after section delcaration…
		section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
		section.boundarySupplementaryItems = [headerItem]
  
		
		let layout = UICollectionViewCompositionalLayout(section: section)
		return layout
		
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		collectionView.register(UINib(nibName: "HeaderSupplementaryView", bundle: nil), forSupplementaryViewOfKind: "header", withReuseIdentifier: "HeaderSupplementaryView")
		collectionView.register(UINib(nibName: "NewBannerSupplementaryView", bundle: nil), forSupplementaryViewOfKind: "new-banner", withReuseIdentifier: "NewBannerSupplementaryView")
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.collectionViewLayout = compositionalLayout
	}


}

extension ViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return colors.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
		cell.backgroundColor = colors[indexPath.row]
		return cell
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 2
	}
	
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		
		switch kind {
			case "header":
				guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderSupplementaryView", for: indexPath) as? HeaderSupplementaryView else {
					return HeaderSupplementaryView()
				}
				
				return headerView
				
			case "new-banner":
				let bannerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "NewBannerSupplementaryView", for: indexPath)
				bannerView.isHidden = indexPath.row % 5 != 0 // show on every 5th item
				return bannerView
				
			default:
				assertionFailure("Unexpected elemend of kind \(kind)")
				return UICollectionReusableView()
		}
		
		
		
	}
	
	
}

extension ViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print(colors[indexPath.row])
	}
}

extension ViewController: UICollectionViewDelegateFlowLayout {

}
