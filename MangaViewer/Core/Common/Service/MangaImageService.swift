//
//  MangaImageService.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 11/07/25.
//

import Combine
import Factory
import Foundation

protocol MangaImageService: APIRequestable {
  func fetchMangaServer(_ chapterID: String) -> AnyPublisher<ServerContainer, APIError>
  func fetchChapterImage(_ baseURL: String, _ hash: String, _ imageName: String) -> AnyPublisher<Data, APIError>
}

struct MangaImageServiceImpl: MangaImageService {
  typealias Requestable = MangaImageRequestable

  @Injected(\.imageCache) private var imageCache

  var session: URLSession

  init(session: URLSession = .shared) {
    self.session = session
  }

  func fetchMangaServer(_ chapterID: String) -> AnyPublisher<ServerContainer, APIError> {
    request(.fetchServer(chapterID))
  }

  func fetchChapterImage(_ baseURL: String, _ hash: String, _ imageName: String) -> AnyPublisher<Data, APIError> {
    print("IMAGE: ", baseURL + "/" + hash + "/" + imageName)
    let key = "\(hash)-\(imageName)"
    guard let cachedData = imageCache.get(forKey: key) else {
      return request(.fetchImage(baseURL, hash, imageName))
        .map { data in
          imageCache.put(data, forKey: key)
          return data
        }
        .eraseToAnyPublisher()
    }

    return Future<Data, APIError> { promise in
      promise(.success(cachedData))
    }
    .eraseToAnyPublisher()
  }
}
