//
//  ReaderView.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 11/07/25.
//

import Factory
import SwiftUI

struct ReaderView: View {
  @InjectedObservable(\.readerViewModel) private var viewModel

  let chapterID: String
  let chapterName: String

  init(_ chapterID: String, _ chapterName: String) {
    self.chapterID = chapterID
    self.chapterName = chapterName
  }

  var body: some View {
    VStack {
      List(viewModel.saverFileNames, id: \.self) { imageName in
        LazyVStack {
          if let data = viewModel.imageDictionary[imageName],
             let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
              .resizable()
              .scaledToFit()
              .clipShape(RoundedRectangle(cornerRadius: 8))
              .accessibilityLabel(imageName)
          } else {
            ProgressView()
              .controlSize(.large)
              .frame(maxWidth: .infinity, maxHeight: .infinity)
              .frame(height: 400)
              .id(UUID())
              .task {
                viewModel.fetchImage(imageName)
              }
          }
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .listRowSeparator(.hidden)
        .listRowBackground(Color.backgroundColor12)
      }
      .listStyle(.plain)
    }
    .navigationTitle(chapterName)
    .task {
      viewModel.fetchChapterServer(chapterID)
    }
  }
}
