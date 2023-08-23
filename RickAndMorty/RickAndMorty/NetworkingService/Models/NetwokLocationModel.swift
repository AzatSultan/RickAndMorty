//
//  NetwokLocationModel.swift
//  RickAndMorty
//
//  Created by Азат Султанов on 20.08.2023.
//

import Foundation

struct BaseNetLocation: Codable {
  let info: NetworkLocationsInfo
  let results: [NetworkLocationsResult]
}

struct NetworkLocationsInfo: Codable {
  let count: Int
  let pages: Int
  let next: String?
  let prev: String?
}

struct NetworkLocationsResult: Codable {
  let id: Int
  let name: String
  let dimension: String
  let residents: [String]
  let url: String
  let created: String
}
