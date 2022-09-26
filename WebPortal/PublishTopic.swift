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
}

public enum PublishValue {
    case codable(Codable)
    case data(Data)
}

public struct MwaError: Codable {
    let type: ErrorType
    let code: Int?
    let url: String?
    let message: String?

    public init(
        type: ErrorType,
        code: Int? = nil,
        url: String? = nil,
        message: String? = nil
    ) {
        self.type = type
        self.code = code
        self.url = url
        self.message = message
    }

    public enum ErrorType: String, Codable {
        case openUrl
    }
}
