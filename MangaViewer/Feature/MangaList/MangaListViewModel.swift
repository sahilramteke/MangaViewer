//
//  MangaListViewModel.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 07/07/25.
//

import Combine
import Factory
import Foundation
import Observation

@MainActor
@Observable
final class MangaListViewModel {
  @ObservationIgnored
  @Injected(\.mangaListService)
  private var service
  @ObservationIgnored
  var cancellables = Set<AnyCancellable>()

  var mangaList: [Manga] = []

  func fetchMangaList() {
    print("MangaListViewModel fetchMangaList called")
    service.fetchMangaList()
      .sink { completion in
        switch completion {
        case .failure(let error):
          print("Error fetchMangaList: ", error)
        case .finished:
          print("Finished fetchMangaList")
        }
      } receiveValue: { data in
        print("fetchMangaList data")
        self.mangaList = data
      }
      .store(in: &cancellables)
  }
}

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
      service.fetchCoverURL(mangaID: mangaID, coverID: coverID)
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
