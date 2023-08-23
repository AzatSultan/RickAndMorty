//
//  CharactersModel.swift
//  RickAndMorty
//
//  Created by Азат Султанов on 20.08.2023.
//

import Foundation

enum Status: String {
  case Alive
  case Dead
  case Unknown
}

enum Gender: String {
  case Male
  case Female
  case Genderless
  case Unknown
}

struct Characters {
  let id: Int
  let name: String
  let status: Status
  let species: String
  let type: String
  let gender: Gender
  let origin: Origin
  let location: Location
  let imageUrl: String
  let episode: [String]
  
  init(netModel: NetworkCharactersResult) {
    self.id = netModel.id
    self.name = netModel.name
    self.status = Status(rawValue: netModel.status) ?? Status.Unknown
    self.species = netModel.species
    self.type = netModel.type
    self.gender = Gender(rawValue: netModel.gender) ?? Gender.Unknown
    self.origin = Origin(name: netModel.origin.name, url: netModel.origin.url)
    self.location = Location(name: netModel.location.name, url: netModel.location.url)
    self.imageUrl = netModel.image
    self.episode = netModel.episode
  }
}

struct Origin {
  let name: String
  let url: String
}

struct Location {
  let name: String
  let url: String
}
