//
//  MangaAttribute.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 11/07/25.
//

struct MangaAttribute: Decodable, Hashable {
  let title: [String: String]
  let altTitles: [[String: String]]
  let description: [String: String]
  let links: [String: String]
  let originalLanguage: String
  let lastVolume: String?
  let lastChapter: String?
  let status: String
  let contentRating: String
  let createdAt: String
  let updatedAt: String
  let version: Int
  let availableTranslatedLanguages: [String]
  let latestUploadedChapter: String?
}
