//
//  MangaListFeature.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 09/07/25.
//

import Combine
import ComposableArchitecture
import Factory

@Reducer
struct MangaListFeature {
  @Injected(\.mangaListService)
  private var service

  @ObservableState
  struct State {
    var mangaList = [Manga]()
    var limit = 100
    var offset = 0
    var isLoadingMore = false
  }

  enum Action {
    case updateMangaList(data: [Manga], offset: Int)
    case fetchManga(offset: Int)
    case loadMore
    case failed(APIError)
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case let .updateMangaList(data, offset):
        state.mangaList += data
        state.offset = offset
        state.isLoadingMore = false
      case let .fetchManga(offset):
        return Effect.publisher {
          service
            .fetchMangaList(limit: state.limit, offset: offset)
            .map { .updateMangaList(data: $0.data, offset: $0.offset) }
            .catch { Just(.failed($0)) }
        }
      case .loadMore:
        guard !state.isLoadingMore
        else { return .none }
        state.isLoadingMore = true
        return .run { [offset = state.offset, limit = state.limit] send in
          await send(.fetchManga(offset: offset + limit))
        }
      case .failed:
        break
      }
      return .none
    }
  }
}
