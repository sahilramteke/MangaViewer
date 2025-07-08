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
  @State var path = NavigationPath()
  var body: some Scene {
    WindowGroup {
        MangaListView()
    }
  }
}
