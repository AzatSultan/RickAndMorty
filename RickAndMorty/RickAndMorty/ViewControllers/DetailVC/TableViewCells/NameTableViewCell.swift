//
//  NameTableViewCell.swift
//  RickAndMorty
//
//  Created by Азат Султанов on 22.08.2023.
//

import UIKit

class NameTableViewCell: UITableViewCell {
  
  static let identifier = "NameCell"
  
  private let characterImage: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.masksToBounds = true
    imageView.layer.cornerRadius = 16
    
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  private let characterName: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 22)
    label.textColor = .white
    return label
  }()
  
  private let statusLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 16)
    label.textColor = UIColor(red: 0.28, green: 0.77, blue: 0.04, alpha: 1)
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    addSubview(characterImage)
    addSubview(characterName)
    addSubview(statusLabel)
    backgroundColor = UIColor(red: 0.02, green: 0.05, blue: 0.12, alpha: 1)
    
    setupLayout()
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupLayout() {
    NSLayoutConstraint.activate([
      characterImage.centerXAnchor.constraint(equalTo: centerXAnchor),
      characterImage.topAnchor.constraint(equalTo: topAnchor, constant: 16),
      characterImage.heightAnchor.constraint(equalToConstant: 148),
      characterImage.widthAnchor.constraint(equalToConstant: 148),
      
      characterName.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: 24),
      characterName.centerXAnchor.constraint(equalTo: centerXAnchor),
      
      statusLabel.topAnchor.constraint(equalTo: characterName.bottomAnchor, constant: 8),
      statusLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      statusLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  public func configure(characterName: String, statusLabel: String, characterImage: String) {
    self.characterName.text = characterName
    self.statusLabel.text = statusLabel
    if let url = URL(string: characterImage) {
      self.characterImage.load(url: url)
    }
  }
  
  

}
