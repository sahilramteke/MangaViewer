//
//  URLRequestable.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 08/07/25.
//
import Foundation

protocol URLRequestable {
  var baseURL: String { get }
  var endpoint: String { get }
  var method: HTTPMethod { get }
  var body: Data? { get }
  var headers: [String: String] { get }
  var queryItems: [String: String] { get }
  var request: URLRequest? { get }
}

enum HTTPMethod: String {
  case delete = "DELETE"
  case get = "GET"
  case post = "POST"
  case put = "PUT"
}

enum NetworkConstants {
  static let baseURLString = "https://api.mangadex.org/"
  static let imageBaseURLString = "https://uploads.mangadex.org/"
}

extension URLRequestable {
  var body: Data? { nil }
  var headers: [String: String] { [:] }
  var queryItems: [String: String] { [:] }
  var request: URLRequest? {
    let urlString = baseURL + endpoint
    var urlComponents = URLComponents(string: urlString)
    urlComponents?.queryItems = queryItems.map { URLQueryItem(name: $0.key, value: $0.value) }
    guard let url = urlComponents?.url
    else { return nil }

    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    request.httpBody = body
    headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }
    return request
  }
}
