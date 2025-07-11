//
//  Router.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 11/07/25.
//

import Factory
import Observation
import SwiftUI

extension Container {
  var router: Factory<Router> {
    self { Router() }.singleton
  }
}

@Observable
class Router {
  var path = NavigationPath()

  init() {
    print("Router initialized")
  }
}
