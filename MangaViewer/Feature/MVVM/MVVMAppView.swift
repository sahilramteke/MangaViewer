//
//  MVVMAppView.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 11/07/25.
//

import Factory
import SwiftUI

struct MVVMAppView: View {
  @InjectedObservable(\.router) var router

  var body: some View {
    NavigationStack(path: $router.path) {
      MangaListView()
    }
  }
}
