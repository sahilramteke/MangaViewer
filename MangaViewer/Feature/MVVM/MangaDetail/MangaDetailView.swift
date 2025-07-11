//
//  MangaDetailView.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 11/07/25.
//

import Factory
import SwiftUI

struct MangaDetailView: View {
  @InjectedObservable(\.mangaDetailViewModel) private var viewModel

  let manga: Manga

  init(manga: Manga) {
    self.manga = manga
  }

  var body: some View {
    VStack {
      ScrollView {
        VStack {
          VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .center) {
              if let data = viewModel.imageData,
                 let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                  .resizable()
                  .scaledToFit()
                  .clipShape(RoundedRectangle(cornerRadius: 8))
                  .accessibilityLabel("\(manga.id)_cover_art")
              } else {
                Image(systemName: "photo.fill")
                  .resizable()
                  .scaledToFit()
                  .clipShape(RoundedRectangle(cornerRadius: 8))
                  .accessibilityLabel("placeholder_image")
              }
            }
            Text(manga.attributes.title.values.first ?? "")
              .font(.headline)
            Text(manga.attributes.description["en"] ?? "")
              .font(.subheadline)

            HStack {
              Text("Chapter List")
                .font(.title2)
                .padding()
                .background(Color.backgroundColor11)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .onTapGesture {
                  viewModel.showFeedList(manga.id)
                }
            }
          }
          .padding()
          .background(
            RoundedRectangle(cornerRadius: 8)
              .stroke(Color.borderColor, lineWidth: 1)
              .fill(Color.backgroundColor)
          )
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.backgroundColor2)
    .navigationTitle(manga.attributes.title.values.first ?? "Manga Details")
    .task {
      viewModel
        .fetchImage(
          mangaID: manga.id,
          coverID: manga.relationships.first { $0.type == "cover_art" }?.id ?? ""
        )
    }
    .navigationDestination(for: DetailRoute.self) { route in
      switch route {
      case let .feedList(mangaID):
        FeedListView(mangaID)
      }
    }
  }
}
