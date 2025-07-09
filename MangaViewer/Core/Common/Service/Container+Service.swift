//
//  Container+Service.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 09/07/25.
//

import Factory

extension Container {
  var mangaListService: Factory<any MangaListService> {
    self { MangaListServiceImp() }
  }

  var coverService: Factory<any CoverImageService> {
    self { CoverImageServiceImpl() }
  }
}
