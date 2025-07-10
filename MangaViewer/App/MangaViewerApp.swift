//
//  MangaViewerApp.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 07/07/25.
//

import ComposableArchitecture
import Factory
import SwiftData
import SwiftUI

@main
struct MangaViewerApp: App {
  @Injected(\.mangaListStore) private var store

  var body: some Scene {
    WindowGroup {
      // MVVM Entry
//      MangaListView()

      // TCA Entry
      TCAMangaListView(store: store)
    }
  }
}
