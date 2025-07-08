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
  var imageData: Data?

  func fetchImage(mangaID: String, coverID: String) {
    if coverImageUrl != nil {
      print("Image aready fetched, skipping fetchCover called")
    } else {
      print("CoverImageViewModel fetchCover called")
      service.fetchCoverImage(mangaID: mangaID, coverID: coverID)
        .sink { _ in
          // on-op
        } receiveValue: { data in
          self.imageData = data
        }
        .store(in: &cancellables)
    }
  }
}
