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

enum MangaListRoute: Hashable {
  case details(Manga)
}

@MainActor
@Observable
final class MangaListViewModel {
  @Injected(\.mangaListService) @ObservationIgnored private var service
  @Injected(\.router) @ObservationIgnored var router

  @ObservationIgnored private var cancellables = Set<AnyCancellable>()

  var mangaList: [Manga] = []
  var limit = 0
  var offset = 0
  var total = 0
  var isLoadingMore = false

  func fetchMangaList(limit: Int = 10, offset: Int = 0) {
    print("fetchMangaList called")
    service.fetchMangaList(limit: limit, offset: offset)
      .sink { result in
        switch result {
        case .finished:
          print("Finished fetchMangaList")
        case let .failure(error):
          print("Error fetchMangaList: \(error)")
        }
        // no-op
      } receiveValue: { container in
        self.mangaList += container.data
        self.limit = container.limit
        self.offset = container.offset
        self.total = container.total
        self.isLoadingMore = false
        print("### offset: \(self.offset) - manga count: \(self.mangaList.count)")
      }
      .store(in: &cancellables)
  }

  func loadMore() {
    print("loadMore called")
    isLoadingMore = true
    fetchMangaList(offset: offset + limit)
  }

  func showManagaDetails(_ manga: Manga) {
    router.path.append(MangaListRoute.details(manga))
  }
}
