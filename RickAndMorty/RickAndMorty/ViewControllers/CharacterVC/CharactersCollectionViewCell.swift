//
//  CharactersCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Азат Султанов on 21.08.2023.
//

import UIKit

class CharactersCollectionViewCell: UICollectionViewCell {
  static let identifier = "CharacterCell"
  
  private let characterName: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 17)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.numberOfLines = 2
    label.textColor = .white
    return label
  }()
  
  private let charactersImage: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.masksToBounds = true
    imageView.layer.cornerRadius = 16
    return imageView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(charactersImage)
    contentView.addSubview(characterName)
    
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupLayout() {
    NSLayoutConstraint.activate([
      characterName.topAnchor.constraint(equalTo: charactersImage.bottomAnchor, constant: 16),
      characterName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
      characterName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
      characterName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
      characterName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      
      charactersImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      charactersImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
      charactersImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
      charactersImage.heightAnchor.constraint(equalToConstant: 140),
    ])
  }
  
  func configure(text: String, imageUrl: String) {
    characterName.text = text
    if let url = URL(string: imageUrl) {
      charactersImage.load(url: url)
    }
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
//    characterName.text = nil
  }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
