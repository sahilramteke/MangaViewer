//
//  ImageCache.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 08/07/25.
//

import Factory
import Foundation

extension Container {
  var imageCache: Factory<ImageCache> {
    self { ImageCache() }
      .singleton
  }
}


final class ImageCache {
  private let cache = NSCache<NSString, NSData>()

  func put(_ data: Data, forKey key: String) {
    cache.setObject(data as NSData, forKey: key as NSString)
  }

  func get(forKey key: String) -> Data? {
    cache.object(forKey: key as NSString) as? Data
  }
}
