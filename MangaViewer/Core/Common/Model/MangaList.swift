//
//  MangaList.swift
//  MangaViewer
//
//  Created by Sahil Ramteke on 07/07/25.
//
import Foundation

struct MangaList: Decodable {
  let result: String
  let response: String
  let data: [Manga]
  let limit: Int
  let offset: Int
  let total: Int
}

struct Manga: Decodable, Hashable {
  let id: String
  let type: String
  let attributes: MangaAttribute
  let relationships: [Relationship]
}

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

struct Relationship: Decodable, Hashable {
  let id: String
  let type: String
}

struct CoverContainer: Decodable {
  let result: String
  let response: String
  let data: Cover
}

struct Cover: Decodable {
  let id: String
  let type: String
  let attributes: CoverAttribute
}

struct CoverAttribute: Decodable {
  let fileName: String
  let createdAt: String
  let updatedAt: String
  let version: Int
}
