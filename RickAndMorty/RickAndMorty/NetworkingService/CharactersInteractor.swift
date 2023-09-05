//
//  DataManagers.swift
//  RickAndMorty
//
//  Created by Азат Султанов on 20.08.2023.
//

import Foundation

protocol CharactersInteractorProtocol {
  func getAllUrls()
  func getCharacters()
  func getCharactersByUrl(url: String)
}

class CharactersInteractor: CharactersInteractorProtocol {
  weak var vc: CharactersVCProtocol?
  
  let networkingManager = NetworkingManager()
//  var netModel: [NetworkCharactersResult] = []
//  var netModelEpisode: [NetworkEpisodeResult] = []
//  var charactersList: [Characters] = []
  
  private var charactersUrl: String = ""
  private var locationsUrl: String = ""
  private var episodesUrl: String = ""
  
  //Получаем ссылки на персонажей, локации, эпизоды и самих персонажей, локации и эпизоды
  func getAllUrls() {
    networkingManager.getBaseResponse { [weak self] result in
      switch result {
      case .success(let baseResponse):
        self?.charactersUrl = baseResponse.characters
        self?.locationsUrl = baseResponse.locations
        self?.episodesUrl = baseResponse.episodes
        self?.getCharacters() //получаем персонажей
//        self?.getEpisodes() //получаем эпизоды
//        self?.getLocations() //получаем локации
        

      case .failure(let error):
        print(error)
      }
    }
  }
  //получаем персонажей
  func getCharacters() {
    networkingManager.getCharacters(url: charactersUrl) { [weak self] result in
      switch result {
      case .success(let baseNetCharacter):
        let charactersList = baseNetCharacter.results.map { Characters(netModel: $0) }
        let nextPageUrl = baseNetCharacter.info.next
        DispatchQueue.main.async {
          self?.vc?.getNextPageUrl(url: nextPageUrl ?? "")
          self?.vc?.updateCharacters(with: charactersList)
        }
        
        
      case .failure(let error):
        print(error)
      }
    }
  }
  
  func getCharactersByUrl(url: String) {
    networkingManager.getCharacters(url: url) { [weak self] result in
      switch result {
      case .success(let baseNetCharacter):
        let charactersList = baseNetCharacter.results.map { Characters(netModel: $0) }
        let nextPageUrl = baseNetCharacter.info.next
        DispatchQueue.main.async {
          self?.vc?.updateCharacters(with: charactersList)
          self?.vc?.getNextPageUrl(url: nextPageUrl ?? "")
        }
        
      case .failure(let error):
        print(error)
      }
    }
  }
  //получаем эпизоды
//  func getEpisodes() {
//    networkingManager.getEpisodes(url: episodesUrl) { [weak self] result in
//      switch result {
//      case .success(let baseNetEpisode):
//        self?.netModelEpisode = baseNetEpisode.results
//      case .failure(let error):
//        print(error)
//      }
//    }
//  }
  //получаем локации
//  func getLocations() {
//    networkingManager.getLocations(url: locationsUrl) { [weak self] result in
//      switch result {
//      case .success(let baseNetLocation): break
//      case .failure(let error):
//        print(error)
//      }
//    }
//  }
  
  
}
