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

enum DetailRoute: Hashable {
  case feedList(_ mangaID: String)
}

@MainActor
@Observable
final class MangaDetailViewModel {
  @Injected(\.coverService) @ObservationIgnored private var service
  @Injected(\.router) @ObservationIgnored var router

  @ObservationIgnored private var cancellables = Set<AnyCancellable>()

  var imageData: Data?

  func fetchImage(mangaID: String, coverID: String) {
    service.fetchCoverImage(mangaID: mangaID, coverID: coverID)
      .sink { _ in
        // on-op
      } receiveValue: { data in
        self.imageData = data
      }
      .store(in: &cancellables)
  }

  func showFeedList(_ mangaID: String) {
    router.path.append(DetailRoute.feedList(mangaID))
  }
}

extension Container {
  var mangaDetailViewModel: Factory<MangaDetailViewModel> {
    self { @MainActor in MangaDetailViewModel() }
  }
}
