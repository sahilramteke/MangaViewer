//
//  MangaViewerApp.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 07/07/25.
//

import SwiftData
import SwiftUI

@main
struct MangaViewerApp: App {
//  var sharedModelContainer: ModelContainer = {
//    let schema = Schema([ Item.self ])
//    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//    do {
//      return try ModelContainer(for: schema, configurations: [modelConfiguration])
//    } catch {
//      fatalError("Could not create ModelContainer:")
//    }
//  }()

  var body: some Scene {
    WindowGroup {
      MangaListView()
    }
//    .modelContainer(sharedModelContainer)
  }
}
