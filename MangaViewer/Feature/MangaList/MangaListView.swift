//
//  MangaListView.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 07/07/25.
//

import Factory
import SwiftUI

struct MangaListView: View {
  @InjectedObservable(\.mangaListViewModel)
  private var model

  var body: some View {
    List(model.mangaList, id: \.id) { item in
      MangaCardView(manga: item)
    }
    .listStyle(.plain)
    .task {
      model.fetchMangaList()
    }
  }
}

#Preview {
  MangaListView()
}
