//
//  NetworkingManager.swift
//  RickAndMorty
//
//  Created by Азат Султанов on 20.08.2023.
//

import Foundation

class NetworkingManager {
    
  private let sessionConfiguration = URLSessionConfiguration.default
  private let session = URLSession.shared
  private let decoder = JSONDecoder()

  //получаем ссылки на characters, locations, episodes
  func getBaseResponse(completion: @escaping (Result<BaseResponse, Error>) -> Void) {
    
    guard let url = URL(string: "https://rickandmortyapi.com/api") else { return }
    
    session.dataTask(with: url) { [weak self] (data, response, error) in
  
      if let error = error {
        DispatchQueue.main.async {
          completion(.failure(error))
        }
        return
      }
      
      if let parsedData = data {
        guard let jsonData = try? self?.decoder.decode(BaseResponse.self, from: parsedData) else {
          return
        }
        
        
        DispatchQueue.main.async {
          completion(.success(jsonData))
        }
      }
    }.resume()
  }
  
  func getCharacters(url: String, completion: @escaping (Result<BaseNetCharacter, Error>) -> Void) {
    
    guard let url = URL(string: url) else { return }
    
    session.dataTask(with: url) { [weak self] (data, response, error) in
  
      if let error = error {
        DispatchQueue.main.async {
          completion(.failure(error))
        }
        return
      }
      
      if let parsedData = data {
        guard let jsonData = try? self?.decoder.decode(BaseNetCharacter.self, from: parsedData) else {
          return
        }
        
        DispatchQueue.main.async {
          completion(.success(jsonData))
        }
      }
    }.resume()
  }
  
  func getEpisodes(url: String, completion: @escaping (Result<[NetworkEpisodeResult], Error>) -> Void) {
    
    guard let url = URL(string: url) else { return }
    
    session.dataTask(with: url) { [weak self] (data, response, error) in
  
      if let error = error {
        DispatchQueue.main.async {
          completion(.failure(error))
        }
        return
      }
      
      if let parsedData = data {
        guard let jsonData = try? self?.decoder.decode([NetworkEpisodeResult].self, from: parsedData) else {
          return
        }
        
        DispatchQueue.main.async {
          completion(.success(jsonData))
        }
      }
    }.resume()
  }
  
  func getLocations(url: String, completion: @escaping (Result<BaseNetLocation, Error>) -> Void) {
    
    guard let url = URL(string: url) else { return }
    
    session.dataTask(with: url) { [weak self] (data, response, error) in
  
      if let error = error {
        DispatchQueue.main.async {
          completion(.failure(error))
        }
        return
      }
      
      if let parsedData = data {
        guard let jsonData = try? self?.decoder.decode(BaseNetLocation.self, from: parsedData) else {
          return
        }
        
        DispatchQueue.main.async {
          completion(.success(jsonData))
        }
      }
    }.resume()
  }
}
