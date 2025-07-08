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
      .map { $0.data }
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
