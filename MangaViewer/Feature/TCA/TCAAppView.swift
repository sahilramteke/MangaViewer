//
//  TCAAppView.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 11/07/25.
//

import Factory
import SwiftUI

struct TCAAppView: View {
  @Injected(\.mangaListStore) private var store

  var body: some View {
    TCAMangaListView(store: store)
  }
}
