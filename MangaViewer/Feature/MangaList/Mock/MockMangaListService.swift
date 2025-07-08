//
//  MockMangaListService.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 08/07/25.
//


import Combine
import Foundation

//struct MockMangaListService: MangaListService {
//  func fetchMangaList() -> AnyPublisher<[Manga], Error> {
//    return Just(try! Data(contentsOf: Bundle.main.url(forResource: "MangaListData", withExtension: "json")!))
//      .decode(type: MangaList.self, decoder: JSONDecoder())
//      .map { $0.data }
//      .eraseToAnyPublisher()
//  }
//}

//struct MockCoverImageService: CoverImageService {
//  return Just(try! Data(contentsOf: Bundle.main.url(forResource: "local", withExtension: "json")!))
//    .decode(type: MangaList.self, decoder: JSONDecoder())
//    .map { $0.data }
//    .eraseToAnyPublisher()
//}

//protocol CoverImageService {
//  func fetchCoverURL(mangaID: String, coverID: String) -> AnyPublisher<URL, Error>
//}
//
//struct CoverImageServiceImpl: CoverImageService {
//  let baseURLString = "https://api.mangadex.org/cover/"
//  let coverBaseURLString = "https://uploads.mangadex.org/covers/"
//
//  func fetchCoverURL(mangaID: String, coverID: String) -> AnyPublisher<URL, Error> {
//    guard let url = URL(string: self.baseURLString + coverID) else {
//      print("Invalid URL")
//      return Fail(
//        error: NSError(domain: "Invalid URL", code: 0, userInfo: nil)
//      )
//      .eraseToAnyPublisher()
//    }
//    print("### url: ", url)
//    return URLSession.shared.dataTaskPublisher(for: URLRequest(url: url))
//      .tryMap({ data, response in
//        guard let httpResponse = response as? HTTPURLResponse,
//              (200...299).contains(httpResponse.statusCode)
//        else {
//          print("HTTP error: ", response)
//          throw URLError(.badServerResponse)
//        }
//        return data
//      })
//      .decode(type: CoverContainer.self, decoder: JSONDecoder())
//      .map { $0.data }
//      .tryMap { data in
//        guard let url = URL(string: coverBaseURLString + "\(mangaID)/\(data.attributes.fileName).512.jpg") else {
//          print("###### tryMap error")
//
//          throw URLError(.badServerResponse)
//        }
//        print("new url: ", url)
//        return url
//      }
//      .mapError({ error in
//        print("###### error  ######: \(error)")
//        return error
//      })
//      .eraseToAnyPublisher()
//  }
//}
