//
//  WebPortalCallback.swift
//  WebPortal
//
//  Created by Maksym Kravchenko on 14.03.2022.
//

import Foundation

public enum CallbackType: String, Codable {
    case authToken
    case exerciserInfo
    case dismiss
    case openFeature
    case openUrlExternally
    case openWebView
    case trainerInfo
}

public struct WebPortalCallback {
    public let type: CallbackType
    public let data: [String: Any]?
}

public enum CallbackKey: String {
    case startingRoute
}

public struct OpenWebViewData {
    public let url: String
    public let endFlowUrlPatterns: [String]

    public init?(info: [String: Any]?) {
        guard let url = info?["url"] as? String,
              let endFlowUrlPatterns = info?["endFlowUrlPatterns"] as? [String] else {
            return nil
        }

        self.url = url
        self.endFlowUrlPatterns = endFlowUrlPatterns
    }
}

public struct OpenUrlExternallyData {
    public let url: URL

    public init?(info: [String: Any]?) {
        guard let urlString = info?["url"] as? String,
                let url = URL(string: urlString) else {
            return nil
        }

        self.url = url
    }
}
