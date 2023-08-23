//
//  DetailViewController.swift
//  RickAndMorty
//
//  Created by Азат Султанов on 22.08.2023.
//

import UIKit

protocol DetailVCProtocol: AnyObject {
  func updateEpisodes(with episodes: [Episode])
}

class DetailViewController: UIViewController, DetailVCProtocol {

  let character: Characters
  
  var interactor: DetailsVCInteractor?
  
  var episodesList: [Episode] = []
  
  var episodesId: [Int] = []
  var episodesUrl: String = "https://rickandmortyapi.com/api/episode/"
  
  let tableView: UITableView = {
    let table = UITableView(frame: .zero, style: .grouped)
    table.translatesAutoresizingMaskIntoConstraints = false
    table.backgroundColor = UIColor(red: 0.02, green: 0.05, blue: 0.12, alpha: 1)
    table.showsVerticalScrollIndicator = false
    table.register(NameTableViewCell.self, forCellReuseIdentifier: NameTableViewCell.identifier)
    table.register(InfoTableViewCell.self, forCellReuseIdentifier: InfoTableViewCell.identifier)
    table.register(OriginTableViewCell.self, forCellReuseIdentifier: OriginTableViewCell.identifier)
    table.register(EpisodeTableViewCell.self, forCellReuseIdentifier: EpisodeTableViewCell.idetifier)
    return table
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupInteractor()
    
    getEpisodesId()
    getEpisodesUrl(ids: episodesId)
    
    interactor?.getEpisodes(url: episodesUrl)
    
    view.addSubview(tableView)
    view.backgroundColor = UIColor(red: 0.02, green: 0.05, blue: 0.12, alpha: 1)
    tableView.separatorColor = tableView.backgroundColor
    tableView.dataSource = self
    tableView.delegate = self
    setupLayout()
    
    navigationController?.navigationBar.prefersLargeTitles = false
    
    
  }
  
  init(character: Characters) {
    self.character = character
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupLayout() {
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
    
    ])
  }
  
  func setupInteractor() {
    let interactor = DetailsVCInteractor()
    interactor.vc = self
    self.interactor = interactor
  }
  
  func updateEpisodes(with episodes: [Episode]) {
    self.episodesList = episodes
    
    tableView.reloadData()
  }
  
  func getEpisodesId() {
    for episode in character.episode {
      if let id = getId(url: episode) {
        episodesId.append(id)
      }
    }
  }
  
  func getId(url: String) -> Int? {
    if let id = url.components(separatedBy: "/").last {
      return Int(id)
    }
    return nil
  }
  
  func getEpisodesUrl(ids: [Int]) {
    for id in ids {
      episodesUrl.append("\(id),")
    }
  }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section < 3 {
      return 1
    } else {
      return episodesList.count
    }
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    4
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    switch indexPath.section {
    case 0:
      let cell = tableView.dequeueReusableCell(withIdentifier: NameTableViewCell.identifier, for: indexPath) as! NameTableViewCell
      cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
      cell.selectionStyle = .none
      cell.configure(characterName: character.name, statusLabel: character.status.rawValue, characterImage: character.imageUrl)
      return cell
    case 1:
      let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.identifier, for: indexPath) as! InfoTableViewCell
      cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
      cell.selectionStyle = .none
      cell.configure(speciesValue: character.species, typeValue: character.type, genderValue: character.gender.rawValue)
      return cell
    case 2:
      let cell = tableView.dequeueReusableCell(withIdentifier: OriginTableViewCell.identifier, for: indexPath) as! OriginTableViewCell
      cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
      cell.selectionStyle = .none
      cell.configure(nameLabel: character.location.name)
      return cell
    default:
      let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeTableViewCell.idetifier, for: indexPath) as! EpisodeTableViewCell
      cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
      cell.selectionStyle = .none
      cell.configure(episodeName: episodesList[indexPath.row].name, episodeNumber: episodesList[indexPath.row].episode, airDate: episodesList[indexPath.row].airDate)
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = HeaderView()
    switch section {
    case 0:
      return nil
    case 1:
      headerView.label.text = "Info"
      return headerView
    case 2:
      headerView.label.text = "Origin"
      return headerView
    default:
      headerView.label.text = "Episodes"
      return headerView
    }
  }
}
