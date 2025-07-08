//
//  MangaListRequestable.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 08/07/25.
//

enum MangaListRequestable: URLRequestable {
  case fetchManga(limit: Int, offset: Int)
//  case fetchMoreManga(String)

  var method: HTTPMethod { .get }
  var baseURL: String { NetworkConstants.baseURLString }
  var endpoint: String {
    switch self {
    case .fetchManga:
      return "manga"
    }
  }
  var queryItems: [String: String]? {
    switch self {
    case let .fetchManga(limit, offset):
      return [
        "limit": String(limit),
        "offset": String(offset),
        "availableTranslatedLanguage[]": "en",
        "order[latestUploadedChapter]": "desc",
        "order[rating]": "desc",
        "contentRating[]": "safe",
      ]
    }
  }
}
