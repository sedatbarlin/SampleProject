//
//  Seminar.swift
//  SampleProject
//
//  Created by Sedat on 21.10.2024.
//

import Foundation

// MARK: - SeminarResponse (for Seminars)
struct SeminarResponse: Codable {
    let status: Int
    let message: String?
    let data: [Seminar]
}

// MARK: - Seminar
struct Seminar: Codable {
    let id: Int
    let name: String
    let subheading: String
    let locationID: Int
    let time: String
    let createdAt: String
    let updatedAt: String
    let gazaSummit: Bool
    let endTime: String
    let location: Location

    enum CodingKeys: String, CodingKey {
        case id, name, subheading
        case locationID = "location_id"
        case time
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case gazaSummit = "gaza_summit"
        case endTime = "end_time"
        case location
    }
}

// MARK: - Location
struct Location: Codable {
    let id: Int
    let title: String
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
