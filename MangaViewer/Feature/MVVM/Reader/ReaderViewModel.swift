//
//  ReaderViewModel.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 11/07/25.
//

import Combine
import Factory
import Foundation
import Observation

@MainActor
@Observable
final class ReaderViewModel {
  @Injected(\.mangaImageService) @ObservationIgnored private var service

  @ObservationIgnored private var cancellables = Set<AnyCancellable>()

  var baseURL: String?
  var hash: String?
  var fileNames: [String] = []
  var saverFileNames: [String] = []
  var imageDictionary: [String: Data] = [:]

  func fetchChapterServer(_ chapterID: String) {
    print("fetchChapterServer called")
    service.fetchMangaServer(chapterID)
      .sink { result in
        switch result {
        case .finished:
          print("Finished fetchChapterServer")
        case let .failure(error):
          print("Error fetchChapterServer: \(error)")
        }
        // no-op
      } receiveValue: { container in
        self.baseURL = container.baseUrl
        self.hash = container.chapter.hash
        self.fileNames = container.chapter.data
        self.saverFileNames = container.chapter.dataSaver
      }
      .store(in: &cancellables)
  }

  func fetchImage(_ imageName: String) {
    print("fetchImage called")
    if let hash, let baseURL {
      service.fetchChapterImage(baseURL, hash, imageName)
        .sink { result in
          switch result {
          case .finished:
            print("Finished fetchImage")
          case let .failure(error):
            print("Error fetchImage: \(error)")
          }
        } receiveValue: { data in
          print("Saved image for: ", imageName)
          self.imageDictionary[imageName] = data
        }
        .store(in: &cancellables)
    } else {
      print("hash and baseURL not present")
    }
  }
}

extension Container {
  var readerViewModel: Factory<ReaderViewModel> {
    self { @MainActor in ReaderViewModel() }
  }
}
