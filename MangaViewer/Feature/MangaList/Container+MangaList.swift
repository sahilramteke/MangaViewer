//
//  Container+MangaList.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 07/07/25.
//

import Factory

extension Container {
  var mangaListService: Factory<MangaListService> {
    self { MangaListServiceImp() }
  }

  var coverService: Factory<CoverImageService> {
    self { CoverImageServiceImpl() }
  }

  var mangaListViewModel: Factory<MangaListViewModel> {
    self { @MainActor in MangaListViewModel() }
  }

  var coverViewModel: Factory<CoverImageViewModel> {
    self { @MainActor in CoverImageViewModel() }
  }
}
