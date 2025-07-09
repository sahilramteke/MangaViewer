//
//  TCAMangaCardView.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 09/07/25.
//

import ComposableArchitecture
import SwiftUI

struct TCAMangaCardView: View {
  @State private var store: StoreOf<MangaCardFeature>
  private let manga: Manga

  init(store: StoreOf<MangaCardFeature>, manga: Manga) {
    self.store = store
    self.manga = manga
  }

  var body: some View {
    LazyVStack(alignment: .leading, spacing: 12) {
      if let data = store.imageData,
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
      Text(manga.attributes.title.values.first ?? "")
        .bold()
    }
    .padding()
    .background(
      RoundedRectangle(cornerRadius: 8)
        .stroke(Color.borderColor, lineWidth: 1)
        .fill(Color.backgroundColor)
    )
    .padding(.horizontal, 16)
    .task {
      store.send(
        .fetchImage(
          mangaID: manga.id,
          coverID: manga
            .relationships
            .first(where: { $0.type == "cover_art" })?.id ?? "")
      )
    }
  }
}
