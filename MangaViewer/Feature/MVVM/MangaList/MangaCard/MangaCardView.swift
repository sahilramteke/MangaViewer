//
//  MangaCardView.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 08/07/25.
//

import Factory
import SwiftUI

struct MangaCardView: View {
  @InjectedObservable(\.coverViewModel)
  private var viewModel

  let manga: Manga

  var body: some View {
    LazyVStack(alignment: .leading, spacing: 12) {
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
      viewModel
        .fetchImage(
          mangaID: manga.id,
          coverID: manga.relationships
            .first(where: { $0.type == "cover_art" })?.id ?? ""
        )
    }
  }
}

#Preview {
  MangaCardView(
    manga: Manga(
      id: "85a99758-de39-471e-9f6d-800547f53d0a",
      type: "manga",
      attributes: MangaAttribute(
        title: ["en": "Test"],
        altTitles: [[:]],
        description: [:],
        links: [:],
        originalLanguage: "",
        lastVolume: nil,
        lastChapter: nil,
        status: "",
        contentRating: "",
        createdAt: "",
        updatedAt: "",
        version: 1,
        availableTranslatedLanguages: [],
        latestUploadedChapter: nil,
      ),
      relationships: [Relationship(id: "450eab69-8fc8-46a3-842c-1890c4bc7f87", type: "cover_art")]
    )
  )
}
