//
//  InfoTableViewCell.swift
//  RickAndMorty
//
//  Created by Азат Султанов on 22.08.2023.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
  
  static let identifier = "InfoCell"
  
  private let speciesLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 16)
    label.textColor = UIColor(red: 0.77, green: 0.79, blue: 0.81, alpha: 1)
    label.textAlignment = .left
    label.text = "Species:"
    return label
  }()
  
  private let typeLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 16)
    label.textColor = UIColor(red: 0.77, green: 0.79, blue: 0.81, alpha: 1)
    label.textAlignment = .left
    label.text = "Type:"
    return label
  }()
  
  private let genderLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 16)
    label.textColor = UIColor(red: 0.77, green: 0.79, blue: 0.81, alpha: 1)
    label.textAlignment = .left
    label.text = "Gender:"
    return label
  }()
  
  private let labelStackVIew: UIStackView = {
    let stack = UIStackView()
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .vertical
    stack.spacing = 16
    stack.alignment = .leading
    return stack
  }()
  
  private let speciesValue: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 16)
    label.textColor = .white
    label.textAlignment = .right
    label.text = "Human"
    return label
  }()
  
  private let typeValue: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 16)
    label.textColor = .white
    label.textAlignment = .right
    label.text = "None"
    return label
  }()
  
  private let genderValue: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 16)
    label.textColor = .white
    label.textAlignment = .right
    label.text = "Male"
    return label
  }()
  
  private let valueStackVIew: UIStackView = {
    let stack = UIStackView()
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .vertical
    stack.spacing = 16
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
    
    labelStackVIew.addArrangedSubview(speciesLabel)
    labelStackVIew.addArrangedSubview(typeLabel)
    labelStackVIew.addArrangedSubview(genderLabel)
    
    valueStackVIew.addArrangedSubview(speciesValue)
    valueStackVIew.addArrangedSubview(typeValue)
    valueStackVIew.addArrangedSubview(genderValue)
    
    content.addSubview(labelStackVIew)
    content.addSubview(valueStackVIew)
    
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
      
      labelStackVIew.topAnchor.constraint(equalTo: content.topAnchor, constant: 16),
      labelStackVIew.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 16),
      labelStackVIew.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -16),

      valueStackVIew.topAnchor.constraint(equalTo: content.topAnchor, constant: 16),
      valueStackVIew.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -16),
      valueStackVIew.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -16),
    ])
  }
  
  public func configure(speciesValue: String, typeValue: String, genderValue: String) {
    self.speciesValue.text = speciesValue
    if typeValue == "" {
      self.typeValue.text = "None"
    } else {
      self.typeValue.text = typeValue
    }
    self.genderValue.text = genderValue
  }

}
