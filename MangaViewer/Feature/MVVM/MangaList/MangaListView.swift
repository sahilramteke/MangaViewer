//
//  MangaListView.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 07/07/25.
//

import Factory
import SwiftUI

struct MangaListView: View {
  @InjectedObservable(\.mangaListViewModel) private var model

  var body: some View {
    VStack {
      List(model.mangaList, id: \.id) { item in
        MangaCardView(manga: item)
          .listRowSeparator(.hidden)
          .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
          .onAppear {
            if model.mangaList.last?.id == item.id && !model.isLoadingMore {
              print("reached last item: ", model.isLoadingMore, item.id)
              model.loadMore()
            }
          }
          .onTapGesture {
            model.showManagaDetails(item)
          }
        if model.isLoadingMore && model.mangaList.last?.id == item.id {
          ProgressView()
            .controlSize(.large)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .listRowSeparator(.hidden)
            .id(UUID())
        }
      }
      .listRowSpacing(16)
      .listStyle(.plain)
    }
    .navigationTitle("Manga Viewer")
    .task {
      model.fetchMangaList()
    }
    .navigationDestination(for: MangaListRoute.self) { route in
      switch route {
      case let .details(manga):
        MangaDetailView(manga: manga)
      }
    }
  }
}

#Preview {
  MangaListView()
}
