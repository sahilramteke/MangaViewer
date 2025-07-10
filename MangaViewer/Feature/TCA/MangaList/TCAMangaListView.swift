//
//  TCAMangaListView.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 09/07/25.
//

import ComposableArchitecture
import SwiftUI

struct TCAMangaListView: View {
  @State private var store: StoreOf<MangaListFeature>

  init(store: StoreOf<MangaListFeature>) {
    self.store = store
  }

  var body: some View {
    VStack {
      List(store.mangaList, id: \.id) { item in
        TCAMangaCardView(
          store: Store( initialState: MangaCardFeature.State()) { MangaCardFeature() },
          manga: item
        )
          .listRowSeparator(.hidden)
          .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
          .onAppear {
            if store.mangaList.last?.id == item.id && !store.isLoadingMore {
              print("reached last item: ", store.isLoadingMore, item.id)
              store.send(.loadMore)
            }
          }
        if store.isLoadingMore && store.mangaList.last?.id == item.id {
          ProgressView()
            .controlSize(.large)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .listRowSeparator(.hidden)
            .id(UUID())
        }
      }
      .listRowSpacing(16)
      .listStyle(.plain)
      .task {
        store.send(.fetchManga(offset: 0))
      }
    }
  }
}
