//
//  CoverImageRequestable.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 08/07/25.
//

enum CoverImageRequestable: URLRequestable {
  case fetchCover(coverID: String)

  var method: HTTPMethod { .get }
  var baseURL: String { NetworkConstants.baseURLString }
  var endpoint: String {
    switch self {
    case let .fetchCover(coverID):
      return "cover/\(coverID)"
    }
  }
}
