//
//  APIRequestable.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 08/07/25.
//

import Combine
import Foundation

protocol APIRequestable {
  associatedtype Requestable where Requestable: URLRequestable

  var session: URLSession { get }

  func request<T: Decodable>(_ requestable: Requestable) -> AnyPublisher<T, APIError> where T: Decodable
}

enum APIError: Error {
  case defaultError(Int, String)
  case invalidRequest
  case invalidResponse
  case invalidJSON(String)
  case unknown
  case validation(String)

  var errorDescription: String? {
    switch self {
    case let .defaultError(statusCode, description):
      return "Error: (\(statusCode)) - \(description)"
    case .invalidRequest:
      return "Invalid request"
    case .invalidResponse:
      return "Invalid response"
    case .invalidJSON(let description):
      return "Invalid JSON: \(description)"
    case .unknown:
      return "Unknown error"
    case .validation(let description):
      return "Validation Error: \(description)"
    }
  }
}

extension APIRequestable {
  func request<T: Decodable>(_ requestable: Requestable) -> AnyPublisher<T, APIError> where T: Decodable {
    guard let request = requestable.request else {
      return Fail(error: APIError.invalidRequest).eraseToAnyPublisher()
    }

    return session.dataTaskPublisher(for: request)
      .tryMap { data, response in
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode)
        else {
          throw APIError.invalidResponse
        }

        return data
      }
      .decode(type: T.self, decoder: JSONDecoder())
      .mapError { error in
        if let error = error as? URLError {
          return .defaultError(error.code.rawValue, error.localizedDescription)
        }

        return .unknown
      }
      .eraseToAnyPublisher()
  }
}
