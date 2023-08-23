//
//  NetworkModel.swift
//  RickAndMorty
//
//  Created by Азат Султанов on 20.08.2023.
//

import Foundation

struct BaseNetCharacter: Codable {
  let info: NetworkCharactersInfo
  let results: [NetworkCharactersResult]
}

struct NetworkCharactersInfo: Codable {
  let count: Int
  let pages: Int
  let next: String?
  let prev: String?
}

struct NetworkCharactersResult: Codable {
  let id: Int
  let name: String
  let status: String
  let species: String
  let type: String
  let gender: String
  let origin: NetworkOrigin
  let location: NetworkLocation
  let image: String
  let episode: [String]
  let url: String
  let created: String
}

struct NetworkOrigin: Codable {
  let name: String
  let url: String
}

struct NetworkLocation: Codable {
  let name: String
  let url: String
}

