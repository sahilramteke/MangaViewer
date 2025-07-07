//
//  MangaListService.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 07/07/25.
//

import Combine
import Foundation

protocol MangaListService {
  func fetchMangaList() -> AnyPublisher<[Manga], Error>
}

struct MangaListServiceImp: MangaListService {
  let baseURLString = "https://api.mangadex.org"
  let mangaListURLString = "/manga"
  let queryParams = "?limit=10&availableTranslatedLanguage[]=en&order[latestUploadedChapter]=desc&order[rating]=desc"

  func fetchMangaList() -> AnyPublisher<[Manga], Error> {
    guard let url = URL(string: self.baseURLString + self.mangaListURLString + queryParams) else {
      print("Invalid URL")
      return Fail(
        error: NSError(domain: "Invalid URL", code: 0, userInfo: nil)
      )
      .eraseToAnyPublisher()
    }
    return URLSession.shared.dataTaskPublisher(for: URLRequest(url: url))
      .tryMap({ data, response in
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode)
        else {
          print("HTTP error: ", response)
          throw URLError(.badServerResponse)
        }
        return data
      })
      .decode(type: MangaList.self, decoder: JSONDecoder())
      .map { $0.data }
      .mapError({ error in
        print("###### error: \(error)")
        return error
      })
      .eraseToAnyPublisher()
  }
}

protocol CoverImageService {
  func fetchCoverURL(mangaID: String, coverID: String) -> AnyPublisher<URL, Error>
}

struct CoverImageServiceImpl: CoverImageService {
  let baseURLString = "https://api.mangadex.org/cover/"
  let coverBaseURLString = "https://uploads.mangadex.org/covers/"

  func fetchCoverURL(mangaID: String, coverID: String) -> AnyPublisher<URL, Error> {
    guard let url = URL(string: self.baseURLString + coverID) else {
      print("Invalid URL")
      return Fail(
        error: NSError(domain: "Invalid URL", code: 0, userInfo: nil)
      )
      .eraseToAnyPublisher()
    }
    print("### url: ", url)
    return URLSession.shared.dataTaskPublisher(for: URLRequest(url: url))
      .tryMap({ data, response in
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode)
        else {
          print("HTTP error: ", response)
          throw URLError(.badServerResponse)
        }
        return data
      })
      .decode(type: CoverContainer.self, decoder: JSONDecoder())
      .map { $0.data }
      .tryMap { data in
        guard let url = URL(string: coverBaseURLString + "\(mangaID)/\(data.attributes.fileName).512.jpg") else {
          print("###### tryMap error")

          throw URLError(.badServerResponse)
        }
        print("new url: ", url)
        return url
      }
      .mapError({ error in
        print("###### error  ######: \(error)")
        return error
      })
      .eraseToAnyPublisher()
  }
}
