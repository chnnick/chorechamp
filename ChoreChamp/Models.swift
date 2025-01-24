//
//  Task.swift
//  ChoreChamp
//
//  Created by Nick Chen on 11/3/24.
//

import Foundation

// TODO: create a model for each table

struct TaskItem: Codable, Identifiable, Hashable {
    var id: Int?
    var taskName: String
    var createdAt: String
    var completed: Bool
    var dueDate: String
    var userId: UUID
    var tradable: Bool
    
    enum CodingKeys: String, CodingKey {
        case completed, tradable
        case id = "task_id"
        case taskName = "task_name"
        case createdAt = "created_at"
        case dueDate = "due_date"
        case userId = "user_id"
    }
}

struct User: Codable {
    var createdAt: String
    var email: String
    var displayName: String
    var profilePictureId: String
    var groupId: Int?
    var endorsementScore: Float
    var userId: Int?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case email
        case displayName = "display_name"
        case profilePictureId = "profile_picture_id"
        case groupId = "group_id"
        case endorsementScore = "endorsement_score"
        case userId = "user_id"
    }
}
