//
//  Container+MangaListFeature.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 10/07/25.
//

import ComposableArchitecture
import Factory

extension Container {
  var mangaListStore: Factory<Store<MangaListFeature.State, MangaListFeature.Action>> {
    self { @MainActor in
      Store(initialState: MangaListFeature.State()) {
        MangaListFeature()._printChanges()
      }
    }
  }

  var coverViewStore: Factory<Store<MangaCardFeature.State, MangaCardFeature.Action>> {
    self { @MainActor in
      Store(initialState: MangaCardFeature.State()) { MangaCardFeature() }
    }
  }
}
