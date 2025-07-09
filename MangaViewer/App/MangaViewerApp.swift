//
//  MangaViewerApp.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 07/07/25.
//

import ComposableArchitecture
import SwiftData
import SwiftUI

@main
struct MangaViewerApp: App {
  var body: some Scene {
    WindowGroup {
      // MVVM Entry
      MangaListView()

//      // TCA Entry
//      TCAMangaListView(store: Store(
//        initialState: MangaListFeature.State(),
//        reducer: { MangaListFeature()._printChanges() }
//      ))
    }
  }
}
