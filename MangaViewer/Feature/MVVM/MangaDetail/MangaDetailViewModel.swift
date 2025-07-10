//
//  MangaDetailViewModel.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 10/07/25.
//

import Combine
import Factory
import Foundation
import Observation

@MainActor
@Observable
final class MangaDetailViewModel {
  @ObservationIgnored
  @Injected(\.mangaListService)
  private var mangaService

  @ObservationIgnored
  @Injected(\.coverService)
  private var coverService

  @ObservationIgnored
  private var cancellables = Set<AnyCancellable>()

  var chapterList = [Chapter]()
  var imageData: Data?

  func fetchMangaFeed(mangaID: String) {
    print("fetchMangaFeed called")
    mangaService.fetchMangaFeed(mangaID: mangaID)
      .sink { result in
        switch result {
        case .finished:
          print("Finished fetchMangaFeed")
        case let .failure(error):
          print("Error fetchMangaFeed: \(error)")
        }
        // no-op
      } receiveValue: { container in
        print("### chapterList: ", container.data)
        self.chapterList = container.data
      }
      .store(in: &cancellables)
  }

  func fetchImage(mangaID: String, coverID: String) {
    coverService.fetchCoverImage(mangaID: mangaID, coverID: coverID)
      .sink { _ in
        // on-op
      } receiveValue: { data in
        self.imageData = data
      }
      .store(in: &cancellables)
  }
}

extension Container {
  var mangaDetailViewModel: Factory<MangaDetailViewModel> {
    self { @MainActor in MangaDetailViewModel() }
  }
}

