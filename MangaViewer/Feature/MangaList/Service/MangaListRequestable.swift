//
//  MangaListRequestable.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 08/07/25.
//

enum MangaListRequestable: URLRequestable {
  case fetchManga

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
    case .fetchManga:
      return [
        "limit": "10",
        "availableTranslatedLanguage[]": "en",
        "order[latestUploadedChapter]": "desc",
        "order[rating]": "desc",
      ]
    }
  }
}
