//
//  Container+ImageCache.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 08/07/25.
//

import Factory

extension Container {
  var imageCache: Factory<ImageCache> {
    self { ImageCache() }
      .singleton
  }
}
