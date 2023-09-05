//
//  LoadingCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Азат Султанов on 25.08.2023.
//

import UIKit

class LoadingCollectionViewCell: UICollectionViewCell {
  
  static let idetifier = "loadingresuableviewid"
  
  let loadingIndicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView()
    indicator.translatesAutoresizingMaskIntoConstraints = false
    indicator.contentMode = .center
    indicator.color = .white
    indicator.style = .medium
    return indicator
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    contentView.addSubview(loadingIndicator)
    setupLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupLayout() {
    NSLayoutConstraint.activate([
      loadingIndicator.topAnchor.constraint(equalTo: contentView.topAnchor),
      loadingIndicator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      loadingIndicator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      loadingIndicator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
}
