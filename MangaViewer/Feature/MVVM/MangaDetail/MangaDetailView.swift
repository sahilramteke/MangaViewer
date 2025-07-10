//
//  MangaDetailView.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 11/07/25.
//

import Factory
import SwiftUI

struct MangaDetailView: View {
  @InjectedObservable(\.mangaDetailViewModel)
  private var viewModel

  @Environment(\.dismiss) var dismiss

  let manga: Manga

  init(manga: Manga) {
    self.manga = manga
  }

  var body: some View {
    VStack {
      HStack {
        Spacer()
        Image(systemName: "xmark")
          .resizable()
          .frame(width: 24, height: 24)
          .padding(8)
          .onTapGesture {
            dismiss()
          }
      }
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

        VStack(alignment: .leading) {
          Text("Chapter List")
            .font(.title)
            .padding()
          ForEach(viewModel.chapterList, id: \.id) { item in
            LazyVStack(alignment: .leading) {
              Text("Chapter \(item.attributes.chapter)")
                .font(.headline)
                .padding()
            }
            .frame(maxWidth: .infinity)
            .background(Color.backgroundColor)
          }
        }
        .padding(.horizontal, 16)

      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.backgroundColor2)
    .task {
      viewModel
        .fetchImage(
          mangaID: manga.id,
          coverID: manga.relationships.first { $0.type == "cover_art" }?.id ?? ""
        )
      viewModel.fetchMangaFeed(mangaID: manga.id)
    }
  }
}
