//
//  MangaListService.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 08/07/25.
//

import Combine
import Foundation

protocol MangaListService: APIRequestable {
  func fetchMangaList(limit: Int, offset: Int) -> AnyPublisher<MangaList, APIError>
}

struct MangaListServiceImp: MangaListService {
  typealias Requestable = MangaListRequestable

  var session: URLSession

  init(session: URLSession = .shared) {
    self.session = session
  }

  func fetchMangaList(limit: Int, offset: Int) -> AnyPublisher<MangaList, APIError> {
    request(.fetchManga(limit: limit, offset: offset))
  }
}
