//
//  CoverImageService.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 08/07/25.
//

import Combine
import Factory
import Foundation

protocol CoverImageService: APIRequestable {
  func fetchCoverImage(mangaID: String, coverID: String) -> AnyPublisher<Data, APIError>
}

struct CoverImageServiceImpl: CoverImageService {
  typealias Requestable = CoverImageRequestable

  @Injected(\.imageCache) private var imageCache

  var session: URLSession

  init(session: URLSession = .shared) {
    self.session = session
  }

  func fetchCoverImage(mangaID: String, coverID: String) -> AnyPublisher<Data, APIError> {
    let key = "\(mangaID)-\(coverID)"
    guard let cachedData = imageCache.get(forKey: key) else {
      return fetchCoverURL(coverID: coverID)
        .flatMap { coverContainer in
          request(.fetchCoverImage(mangaID: mangaID, fileName: coverContainer.data.attributes.fileName))
            .map { data in
              imageCache.put(data, forKey: key)
              return data
            }
        }
        .eraseToAnyPublisher()
    }

    return Future<Data, APIError> { promise in
      promise(.success(cachedData))
    }
    .eraseToAnyPublisher()
  }

  private func fetchCoverURL(coverID: String) -> AnyPublisher<CoverContainer, APIError> {
    request(.fetchCover(coverID: coverID))
  }
}
