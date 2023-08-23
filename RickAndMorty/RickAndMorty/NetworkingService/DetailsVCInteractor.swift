//
//  DetailsVCInteractor.swift
//  RickAndMorty
//
//  Created by Азат Султанов on 23.08.2023.
//

import Foundation

protocol DetailsVCInteractorProtocol {
  func getEpisodes(url: String)
}

class DetailsVCInteractor: DetailsVCInteractorProtocol {
  weak var vc: DetailVCProtocol?
  
  let networkingManager = NetworkingManager()
  
  func getEpisodes(url: String) {
    networkingManager.getEpisodes(url: url) { [weak self] result in
      switch result {
      case .success(let baseNetEpisode):
        
        let episodesList = baseNetEpisode.map { Episode(netModel: $0) }
        DispatchQueue.main.async {
          self?.vc?.updateEpisodes(with: episodesList)
        }
        
      case .failure(let error):
        print(error)
      }
    }
  }
  
  
}
