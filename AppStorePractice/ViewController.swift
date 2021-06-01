//
//  ViewController.swift
//  AppStorePractice
//
//  Created by Viennarz Curtiz on 5/14/21.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var collectionView: UICollectionView!
	
	let colors =  [UIColor.red, UIColor.yellow, UIColor.systemPink, UIColor.systemGreen, UIColor.systemBlue, UIColor.systemTeal, UIColor.brown, UIColor.cyan, UIColor.systemGray3,]
	
	let flowLayout: UICollectionViewFlowLayout = {
		let layout = UICollectionViewFlowLayout()
		layout.minimumInteritemSpacing = 5
		layout.minimumLineSpacing = 5
		layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
		return layout
	}()
	
	var selectedCompLayout: CompLayout = .one
	
	enum CompLayout {
		case one
		case two
		case three
		case four
	}
	
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
		
//		//header
//		let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
//		let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: "header", alignment: .top)
//		headerItem.pinToVisibleBounds = true
		
		//background
		
		let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: "background")
		let backgroundInset: CGFloat = 8
		backgroundItem.contentInsets = NSDirectionalEdgeInsets(top: backgroundInset, leading: backgroundInset, bottom: backgroundInset, trailing: backgroundInset)
		
		
		//section
		let section = NSCollectionLayoutSection(group: group)
		
		let sectionInset: CGFloat = 16
		section.contentInsets = NSDirectionalEdgeInsets(top: sectionInset, leading: sectionInset, bottom: sectionInset, trailing: sectionInset)
		
		// after section delcaration…
//		section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
		section.decorationItems = [backgroundItem]
//		section.boundarySupplementaryItems = [headerItem]
		
		let layout = UICollectionViewCompositionalLayout(section: section)
	
		layout.register(UINib(nibName: "BackgroundSupplementaryView", bundle: nil), forDecorationViewOfKind: "background")
		return layout
		
	}()
	
	let compositionalLayoutFour = UICollectionViewCompositionalLayout { (index, environment) -> NSCollectionLayoutSection? in
		let itemsPerRow = environment.traitCollection.horizontalSizeClass == .compact ? 3 : 6 //compact for iphones else ipad
		let fraction: CGFloat = 1 / CGFloat(itemsPerRow)
		let inset: CGFloat = 2.5
		
		//Item
		let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalHeight(1))
		
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
		
		// Group
		let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(fraction))
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
		
		// Section
		let section = NSCollectionLayoutSection(group: group)
		section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
		
		// Supplementary Item
		let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
		let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: "header", alignment: .top)
		section.boundarySupplementaryItems = [headerItem]
		
		return section
		
	}
	
	let compositionalLayoutTwo: UICollectionViewCompositionalLayout = {
		let inset: CGFloat = 2.5
		
		
		//large Item
		let largeItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
		let largeItem = NSCollectionLayoutItem(layoutSize: largeItemSize)
		largeItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
		
		//small Item Size
		let smallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
		let smallItem = NSCollectionLayoutItem(layoutSize: smallItemSize)
		smallItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
		
		
		
		// Vertical group
		let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1))
		let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitems: [smallItem])
		
		let nestedGroup = verticalGroup
		
		//Outer group
		let outerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.5))
		
		let outerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: outerGroupSize, subitems: [largeItem, nestedGroup, nestedGroup])
		
		//section
		
		let section = NSCollectionLayoutSection(group: outerGroup)
		section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
		
		return UICollectionViewCompositionalLayout(section: section)
	}()
	
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
		
		collectionView.register(UINib(nibName: "HeaderSupplementaryView", bundle: nil), forSupplementaryViewOfKind: "header", withReuseIdentifier: "HeaderSupplementaryView")
		collectionView.register(UINib(nibName: "NewBannerSupplementaryView", bundle: nil), forSupplementaryViewOfKind: "new-banner", withReuseIdentifier: "NewBannerSupplementaryView")
		collectionView.dataSource = self
		collectionView.delegate = self
		
		
		switch selectedCompLayout {
			
			case .one:
				collectionView.collectionViewLayout = compositionalLayout
			case .two:
				collectionView.collectionViewLayout = compositionalLayoutTwo
			case .three:
				collectionView.collectionViewLayout = compositionalLayoutThree
			case .four:
				collectionView.collectionViewLayout = compositionalLayoutFour
		}
		
		
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
		return 4
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
