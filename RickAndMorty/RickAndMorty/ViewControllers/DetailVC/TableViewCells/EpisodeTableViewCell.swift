//
//  EpisodeTableViewCell.swift
//  RickAndMorty
//
//  Created by Азат Султанов on 22.08.2023.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {
  
  static let idetifier = "EpisodeCell"
  
  private let episodeName: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Pilot"
    label.font = UIFont.systemFont(ofSize: 17)
    label.textColor = .white
    label.textAlignment = .left
    return label
  }()
  
  private let episodeNumber: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Episode: 1, Season: 1"
    label.font = UIFont.systemFont(ofSize: 13)
    label.textColor = UIColor(red: 0.28, green: 0.77, blue: 0.04, alpha: 1)
    label.textAlignment = .left
    return label
  }()
  
  private let airDate: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "December 3, 2013"
    label.font = UIFont.systemFont(ofSize: 12)
    label.textColor = UIColor(red: 0.58, green: 0.6, blue: 0.61, alpha: 1)
    label.textAlignment = .left
    return label
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
    content.addSubview(episodeName)
    content.addSubview(episodeNumber)
    content.addSubview(airDate)
    
    addSubview(content)
    
    backgroundColor = UIColor(red: 0.02, green: 0.05, blue: 0.12, alpha: 1)
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
      content.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
      
      episodeName.topAnchor.constraint(equalTo: content.topAnchor, constant: 16),
      episodeName.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 15.25),
      
      episodeNumber.topAnchor.constraint(equalTo: episodeName.bottomAnchor, constant: 16),
      episodeNumber.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 15.25),
      episodeNumber.bottomAnchor.constraint(equalTo: content.bottomAnchor , constant: -14),
      
      airDate.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -15.68),
      airDate.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -16)
    ])
  }
  
  public func configure(episodeName: String, episodeNumber: String, airDate: String) {
    self.episodeName.text = episodeName
    let stringArray = episodeNumber.components(separatedBy: CharacterSet.decimalDigits.inverted)
    if let episode = Int(stringArray[2]), let season = Int(stringArray[1]) {
      self.episodeNumber.text = "Episode: \(episode), Season: \(season)"
    }
    
    self.airDate.text = airDate
  }
}
