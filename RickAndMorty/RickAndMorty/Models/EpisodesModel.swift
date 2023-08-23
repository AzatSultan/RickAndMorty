//
//  EpisodesModel.swift
//  RickAndMorty
//
//  Created by Азат Султанов on 20.08.2023.
//

import Foundation

struct Episode {
  let id: Int
  let name: String
  let airDate: String
  let episode: String
//  let characters: [String]
  
  init(netModel: NetworkEpisodeResult) {
    self.id = netModel.id
    self.name = netModel.name
    self.airDate = netModel.airDate
    self.episode = netModel.episode
  }
}
