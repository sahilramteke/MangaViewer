//
//  FeedListViewModel.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 11/07/25.
//

import Combine
import Factory
import Foundation
import Observation

enum FeedListRoute: Hashable {
  case readerView(_ chapterID: String, _ chapterName: String)
}

@MainActor
@Observable
final class FeedListViewModel {
  @Injected(\.mangaListService) @ObservationIgnored private var service
  @Injected(\.router) @ObservationIgnored var router

  @ObservationIgnored private var cancellables = Set<AnyCancellable>()

  var chapters = [Chapter]()

  func fetchMangaFeed(_ mangaID: String) {
    print("fetchMangaFeed called")
    service.fetchMangaFeed(mangaID: mangaID)
      .sink { result in
        switch result {
        case .finished:
          print("Finished fetchMangaFeed")
        case let .failure(error):
          print("Error fetchMangaFeed: \(error)")
        }
        // no-op
      } receiveValue: { container in
        print("### chapterList: ", container.data.count)
        self.chapters = container.data
      }
      .store(in: &cancellables)
  }

  func showReaderView(chapterID: String, chapterName: String) {
    router.path.append(FeedListRoute.readerView(chapterID, chapterName))
  }
}

extension Container {
  var feedListViewModel: Factory<FeedListViewModel> {
    self { @MainActor in FeedListViewModel() }
  }
}
