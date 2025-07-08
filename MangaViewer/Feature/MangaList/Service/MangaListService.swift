//
//  MangaListService.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 08/07/25.
//

import Combine
import Foundation

protocol MangaListService: APIRequestable {
  func fetchMangaList() -> AnyPublisher<MangaList, APIError>
}

struct MangaListServiceImp: MangaListService {
  typealias Requestable = MangaListRequestable

  var session: URLSession

  init(session: URLSession = .shared) {
    self.session = session
  }

  func fetchMangaList() -> AnyPublisher<MangaList, APIError> {
    request(.fetchManga)
  }
}
