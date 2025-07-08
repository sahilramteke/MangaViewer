//
//  CoverImageRequestable.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 08/07/25.
//

enum CoverImageRequestable: URLRequestable {
  case fetchCover(coverID: String)
  case fetchCoverImage(mangaID: String, fileName: String)

  var method: HTTPMethod { .get }
  var baseURL: String {
    switch self {
    case .fetchCover:
      NetworkConstants.baseURLString
    case .fetchCoverImage:
      NetworkConstants.imageBaseURLString
    }
  }

  var endpoint: String {
    switch self {
    case let .fetchCover(coverID):
      return "cover/\(coverID)"
    case let .fetchCoverImage(mangaID, fileName):
      return "covers/\(mangaID)/\(fileName).512.jpg"
    }
  }
}
