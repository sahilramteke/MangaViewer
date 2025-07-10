//
//  Cover.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 11/07/25.
//

struct Cover: Decodable {
  let id: String
  let type: String
  let attributes: CoverAttribute
}
