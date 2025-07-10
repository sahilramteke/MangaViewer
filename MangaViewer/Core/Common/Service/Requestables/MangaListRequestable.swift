//
//  MangaListRequestable.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 08/07/25.
//

enum MangaListRequestable: URLRequestable {
  case fetchManga(limit: Int, offset: Int)
  case fetchMangaFeed(mangaID: String)

  var method: HTTPMethod { .get }
  var baseURL: String { NetworkConstants.baseURLString }
  var endpoint: String {
    switch self {
    case .fetchManga:
      return "manga"
    case let .fetchMangaFeed(mangaID):
      return "manga/\(mangaID)/feed"
    }
  }
  var queryItems: [String: String] {
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
    case .fetchMangaFeed:
      return [
        "limit": "500",
        "translatedLanguage[]": "en",
        "contentRating[]": "safe",
        "order[volume]": "asc",
        "order[chapter]": "asc",
        "includeUnavailable": "0",
      ]
    }
  }
}
