//
//  FeedListView.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 11/07/25.
//

import Factory
import SwiftUI

struct FeedListView: View {
  @InjectedObservable(\.feedListViewModel) private var viewModel

  let mangaID: String

  init(_ mangaID: String) {
    self.mangaID = mangaID
  }

  var body: some View {
    VStack {
      List(viewModel.chapters, id: \.id) { item in
        LazyVStack(alignment: .leading) {
          Text("Chapter \(item.attributes.chapter)")
            .font(.headline)
            .padding()
        }
        .background(Color.backgroundColor13)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .listRowBackground(Color.backgroundColor12)
      }
      .scrollContentBackground(.hidden)
    }
    .navigationTitle("Chapters")
    .background(Color.backgroundColor11)
    .task {
      viewModel.fetchMangaFeed(mangaID)
    }
  }
}
