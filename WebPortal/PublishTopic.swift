//
//  PublishTopic.swift
//  WebPortal
//
//  Created by Maksym Kravchenko on 14.03.2022.
//

import Foundation

public enum PublishTopic: String, Codable {
    case authToken
    case error
    case exerciserInfo
    case openWebView
    case trainerInfo
}

public enum PublishValue {
    case codable(Codable)
    case data(Data)
}

public struct CallbackError: Codable {
    public let type: CallbackType
    public let code: Int?
    public let url: String?
    public let message: String?

    public init(
        type: CallbackType,
        code: Int? = nil,
        url: String? = nil,
        message: String? = nil
    ) {
        self.type = type
        self.code = code
        self.url = url
        self.message = message
    }
}
