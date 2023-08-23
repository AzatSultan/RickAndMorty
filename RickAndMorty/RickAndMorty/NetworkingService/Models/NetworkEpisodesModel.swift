//
//  NetworkEpisodeModel.swift
//  RickAndMorty
//
//  Created by Азат Султанов on 20.08.2023.
//

import Foundation

struct BaseNetEpisode: Codable {
  let info: NetworkEpisodeInfo
  let results: [NetworkEpisodeResult]
}

struct NetworkEpisodeInfo: Codable {
  let count: Int
  let pages: Int
  let next: String?
  let prev: String?
}

struct NetworkEpisodeResult: Codable {
  let id: Int
  let name: String
  let airDate: String
  let episode: String
  let characters: [String]
  let url: String
  let created: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case airDate = "air_date"
    case episode
    case characters
    case url
    case created
  }
}
