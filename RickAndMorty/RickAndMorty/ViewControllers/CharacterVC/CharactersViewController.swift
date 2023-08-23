//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Азат Султанов on 20.08.2023.
//

import UIKit

protocol CharactersVCProtocol: AnyObject {
  func updateCharacters(with characters: [Characters])
}

class CharactersViewController: UICollectionViewController, CharactersVCProtocol {
  
  var interactor: CharactersInteractorProtocol?
  
  var charactersList: [Characters] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupInteractor()
    
    interactor?.getAllUrls()
    
    setupCollectionView()
    
    collectionView.backgroundColor = UIColor(red: 0.02, green: 0.05, blue: 0.12, alpha: 1)
    
    setupTitle()
    
  }
  
  
  func setupTitle() {
    if #available(iOS 15, *) {
      let appearance = UINavigationBarAppearance()
      appearance.configureWithOpaqueBackground()
      appearance.backgroundColor = UIColor(red: 0.02, green: 0.05, blue: 0.12, alpha: 1)
      appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
      appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
      self.navigationController?.navigationBar.isTranslucent = true  // pass "true" for fixing iOS 15.0 black bg issue
      self.navigationController?.navigationBar.tintColor = UIColor.white // We need to set tintcolor for iOS 15.0
      appearance.shadowColor = .clear    //removing navigationbar 1 px bottom border.
      navigationController?.navigationBar.standardAppearance = appearance
      navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.title = "Characters"
    navigationItem.backButtonTitle = ""
  }
  
  func setupInteractor() {
    let interactor = CharactersInteractor()
    interactor.vc = self
    self.interactor = interactor
  }
  
  func updateCharacters(with characters: [Characters]) {
    self.charactersList = characters
    
    collectionView.reloadData()
  }
  
  private func setupCollectionView() {
    view.addSubview(collectionView)
    collectionView.dataSource = self
    collectionView.dataSource = self
    collectionView.collectionViewLayout = createLayout()
    collectionView.showsVerticalScrollIndicator = false
    collectionView.register(CharactersCollectionViewCell.self, forCellWithReuseIdentifier: CharactersCollectionViewCell.identifier)
    
  }
  
  private func createLayout() -> UICollectionViewLayout {
    let spacing: CGFloat = 16
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(0.5),
      heightDimension: .fractionalHeight(1.0))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .absolute(202))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
    group.interItemSpacing = .fixed(spacing)
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = .init(top: spacing, leading: CGFloat(20), bottom: spacing, trailing: CGFloat(20))
    section.interGroupSpacing = spacing
    let layout = UICollectionViewCompositionalLayout(section: section)
    return layout
  }
  
  private func presentDetails(vc: DetailViewController) {
    navigationController?.pushViewController(vc, animated: true)
  }
}

extension CharactersViewController {
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    charactersList.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharactersCollectionViewCell.identifier, for: indexPath) as! CharactersCollectionViewCell
    cell.backgroundColor = UIColor(red: 0.15, green: 0.16, blue: 0.22, alpha: 1)
    cell.layer.cornerRadius = 16
    cell.configure(text: charactersList[indexPath.row].name, imageUrl: charactersList[indexPath.row].imageUrl)
    return cell
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    1
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let selectedItem = charactersList[indexPath.row]
    let vc = DetailViewController(character: selectedItem)
    presentDetails(vc: vc)
  }
  
}

