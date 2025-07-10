//
//  Manga.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 07/07/25.
//

struct Manga: Decodable, Hashable {
  let id: String
  let type: String
  let attributes: MangaAttribute
  let relationships: [Relationship]
}
