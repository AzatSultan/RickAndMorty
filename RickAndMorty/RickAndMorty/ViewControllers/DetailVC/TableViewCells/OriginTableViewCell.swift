//
//  OriginTableViewCell.swift
//  RickAndMorty
//
//  Created by Азат Султанов on 22.08.2023.
//

import UIKit

class OriginTableViewCell: UITableViewCell {
  
  static let identifier = "OriginCell"
  
  private let planetImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "planet")
    imageView.contentMode = .center
    imageView.backgroundColor = UIColor(red: 0.1, green: 0.11, blue: 0.16, alpha: 1)
    imageView.layer.masksToBounds = true
    imageView.layer.cornerRadius = 10
    return imageView
  }()
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Earth"
    label.textColor = .white
    label.textAlignment = .left
    label.font = UIFont.systemFont(ofSize: 17)
    return label
  }()
  
  private let typeLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Planet"
    label.font = UIFont.systemFont(ofSize: 13)
    label.textColor = UIColor(red: 0.28, green: 0.77, blue: 0.04, alpha: 1)
    label.textAlignment = .left
    return label
  }()
  
  private let planetStack: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.spacing = 8
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.backgroundColor = .clear
    return stack
  }()
  
  private let content: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(red: 0.15, green: 0.16, blue: 0.22, alpha: 1)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.masksToBounds = true
    view.layer.cornerRadius = 16
    return view
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    backgroundColor = UIColor(red: 0.02, green: 0.05, blue: 0.12, alpha: 1)
    
    planetStack.addArrangedSubview(nameLabel)
    planetStack.addArrangedSubview(typeLabel)
    content.addSubview(planetStack)
    content.addSubview(planetImageView)
    addSubview(content)
    
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupLayout() {
    NSLayoutConstraint.activate([
      content.topAnchor.constraint(equalTo: topAnchor),
      content.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
      content.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
      content.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      planetImageView.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 8),
      planetImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
      planetImageView.heightAnchor.constraint(equalToConstant: 64),
      planetImageView.widthAnchor.constraint(equalToConstant: 64),
      
      planetStack.leadingAnchor.constraint(equalTo: planetImageView.trailingAnchor, constant: 16),
      planetStack.topAnchor.constraint(equalTo: content.topAnchor, constant: 16),
      planetStack.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -16),
    ])
  }
  
  func configure(nameLabel: String) {
    self.nameLabel.text = nameLabel
  }

}
