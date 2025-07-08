//
//  CoverImageViewModel.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 08/07/25.
//

import Combine
import Factory
import Foundation
import Observation

@MainActor
@Observable
final class CoverImageViewModel {
  @ObservationIgnored
  @Injected(\.coverService)
  private var service
  @ObservationIgnored
  var cancellables = Set<AnyCancellable>()

  var coverImageUrl: URL?

  func fetchCoverURL(mangaID: String, coverID: String) {
    if coverImageUrl != nil {
      print("Image aready fetched, skipping fetchCover called")
    } else {
      print("CoverImageViewModel fetchCover called")
      service.fetchCoverURL(coverID: coverID)
        .map { $0.data }
        .tryMap { data in
          let baseString = "https://uploads.mangadex.org/covers/"
          guard let url = URL(string: baseString + "\(mangaID)/\(data.attributes.fileName).512.jpg")
          else {
            throw APIError.invalidResponse
          }
          return url
        }
        .sink { completion in
          switch completion {
          case .failure(let error):
            print("Error fetchCoverURL: ", error)
          case .finished:
            print("Finished fetchCoverURL")
          }
        } receiveValue: { data in
          print("fetchCoverURL data: ", data)
          self.coverImageUrl = data
        }
        .store(in: &cancellables)
    }
  }
}
