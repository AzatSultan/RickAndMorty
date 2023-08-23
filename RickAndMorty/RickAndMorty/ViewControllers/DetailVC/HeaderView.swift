//
//  HeaderView.swift
//  RickAndMorty
//
//  Created by Азат Султанов on 22.08.2023.
//

import UIKit

class HeaderView: UIView {

  let label: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 17)
    label.text = "Info"
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(label)
    backgroundColor = UIColor(red: 0.02, green: 0.05, blue: 0.12, alpha: 1)
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupLayout() {
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: topAnchor, constant: 24),
      label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
      label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24)
    ])
  }
  
}
