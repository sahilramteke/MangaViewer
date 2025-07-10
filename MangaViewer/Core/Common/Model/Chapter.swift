//
//  Chapter.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 11/07/25.
//

struct Chapter: Decodable {
  let id: String
  let type: String
  let attributes: ChapterAtrribute
  let relationships: [Relationship]
}
