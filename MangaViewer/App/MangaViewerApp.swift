//
//  MangaViewerApp.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 07/07/25.
//

import SwiftUI

@main
struct MangaViewerApp: App {
  var body: some Scene {
    WindowGroup {
      MVVMAppView() // MVVM Entry
//      TCAAppView() // TCA Entry
    }
  }
}
