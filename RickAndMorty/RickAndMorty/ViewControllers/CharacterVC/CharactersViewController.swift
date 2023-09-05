//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Азат Султанов on 20.08.2023.
//

import UIKit

enum Section: Int, CaseIterable {
  case load
  case list
  
  var columnCount: Int {
    switch self {
    case .load:
      return 2
    case .list:
      return 1
    }
  }
}

protocol CharactersVCProtocol: AnyObject {
  func updateCharacters(with characters: [Characters])
  func getNextPageUrl(url: String)
}

class CharactersViewController: UICollectionViewController, CharactersVCProtocol {
  
  var interactor: CharactersInteractorProtocol?
  
  var charactersList: [Characters] = []
  
  var nextPageUrl: String = ""
  
  var isLoading = false
  
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
    self.charactersList.append(contentsOf: characters)
    collectionView.reloadData()
  }
  
  func getNextPageUrl(url: String) {
    self.nextPageUrl = url
  }
  
  private func setupCollectionView() {
    view.addSubview(collectionView)
    collectionView.dataSource = self
    collectionView.dataSource = self
    collectionView.collectionViewLayout = createLayout()
    collectionView.showsVerticalScrollIndicator = false
    collectionView.register(CharactersCollectionViewCell.self, forCellWithReuseIdentifier: CharactersCollectionViewCell.identifier)
    collectionView.register(LoadingCollectionViewCell.self, forCellWithReuseIdentifier: LoadingCollectionViewCell.idetifier)
  }
  
  private func createLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
      
      guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
      
      let columns = sectionKind.columnCount
      
      let itemSize = columns == 1 ?
      NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                             heightDimension: .fractionalHeight(1.0)) :
      NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                             heightDimension: .fractionalHeight(1.0))
      
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
      item.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
      
      let groupHeight = columns == 1 ?
      NSCollectionLayoutDimension.absolute(65) :
      NSCollectionLayoutDimension.absolute(220)
      
      let groupSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: groupHeight)
      
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: columns)
      
      let section = NSCollectionLayoutSection(group: group)
      section.contentInsets = .init(top: 8, leading: 8, bottom: 0, trailing: 8)
      return section
    }
    return layout
  }
  
  private func presentDetails(vc: DetailViewController) {
    navigationController?.pushViewController(vc, animated: true)
  }
}

extension CharactersViewController {
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    //    charactersList.count
    if section == 0 {
      return charactersList.count
    } else if section == 1 {
      return 1
    } else {
      return 0
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch indexPath.section {
    case 0:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharactersCollectionViewCell.identifier, for: indexPath) as! CharactersCollectionViewCell
      cell.backgroundColor = UIColor(red: 0.15, green: 0.16, blue: 0.22, alpha: 1)
      cell.layer.cornerRadius = 16
      cell.configure(text: charactersList[indexPath.row].name, imageUrl: charactersList[indexPath.row].imageUrl)
      return cell
    default:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadingCollectionViewCell.idetifier, for: indexPath) as! LoadingCollectionViewCell
      cell.layer.cornerRadius = 16
      cell.loadingIndicator.startAnimating()
      return cell
    }
    
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    2
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if indexPath.section == 0 {
      let selectedItem = charactersList[indexPath.row]
      let vc = DetailViewController(character: selectedItem)
      presentDetails(vc: vc)
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    if indexPath.section == 1 {
      loadMoreData()
    }
  }
  
  // Download more data here
  func loadMoreData() {
    DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) {
      DispatchQueue.main.async {
        if self.nextPageUrl != "" {
          self.interactor?.getCharactersByUrl(url: self.nextPageUrl)
          print(self.charactersList.count)
        }
      }
    }
  }
  
}

