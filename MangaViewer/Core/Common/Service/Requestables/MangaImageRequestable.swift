//
//  MangaImageRequestable.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 11/07/25.
//

enum MangaImageRequestable: URLRequestable {
  case fetchImage(_ baseURL: String, _ hash: String, _ imageName: String)
  case fetchServer(_ chapterID: String)

  var method: HTTPMethod { .get }
  var baseURL: String {
    switch self {
    case .fetchImage:
      return ""
    case .fetchServer:
      return NetworkConstants.baseURLString
    }
  }
  var endpoint: String {
    switch self {
    case let .fetchServer(chapterID):
      return "at-home/server/\(chapterID)"
    case let .fetchImage(baseURL, hash, imageName):
      return "\(baseURL)/data-saver/\(hash)/\(imageName)"
    }
  }
}
