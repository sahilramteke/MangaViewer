//
//  ChapterData.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 11/07/25.
//

struct ChapterData: Decodable {
  let hash: String
  let data: [String]
  let dataSaver: [String]
}
