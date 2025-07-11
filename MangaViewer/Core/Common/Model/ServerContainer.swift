//
//  ServerContainer.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 11/07/25.
//

struct ServerContainer: Decodable {
  let result: String
  let baseUrl: String
  let chapter: ChapterData
}
