//
//  MangaCardFeature.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 09/07/25.
//

import Combine
import ComposableArchitecture
import Factory
import Foundation

@Reducer
struct MangaCardFeature {
  @Injected(\.coverService)
  private var service

  @ObservableState
  struct State {
    var imageData: Data?
  }

  enum Action {
    case updateImage(data: Data)
    case fetchImage(mangaID: String, coverID: String)
    case failed(APIError)
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case let .updateImage(data):
        state.imageData = data
      case let .fetchImage(mangaID, coverID):
        return Effect.publisher {
          service
            .fetchCoverImage(mangaID: mangaID, coverID: coverID)
            .map { .updateImage(data: $0) }
            .catch { Just(.failed($0)) }
        }
      case .failed:
        break
      }
      return .none
    }
  }
}
