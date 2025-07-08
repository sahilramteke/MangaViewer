//
//  CoverImageService.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 08/07/25.
//

import Combine
import Foundation

protocol CoverImageService: APIRequestable {
  func fetchCoverURL(coverID: String) -> AnyPublisher<CoverContainer, APIError>
}

struct CoverImageServiceImpl: CoverImageService {
  typealias Requestable = CoverImageRequestable

  var session: URLSession

  init(session: URLSession = .shared) {
    self.session = session
  }

  func fetchCoverURL(coverID: String) -> AnyPublisher<CoverContainer, APIError> {
    request(.fetchCover(coverID: coverID))
  }
}
