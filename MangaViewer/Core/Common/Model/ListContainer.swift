//
//  ListContainer.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 11/07/25.
//

struct ListContainer<T>: Decodable where T: Decodable {
  let result: String
  let response: String
  let data: [T]
  let limit: Int
  let offset: Int
  let total: Int
}
