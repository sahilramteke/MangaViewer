//
//  ChapterAtrribute.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 11/07/25.
//

struct ChapterAtrribute: Decodable {
  let chapter: String
  let pages: Int
  let isUnavailable: Bool
  let version: Int
}
