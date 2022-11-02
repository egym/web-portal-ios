//
//  WebPortalServiceProtocol.swift
//  WebPortal
//
//  Created by Maksym Kravchenko on 01.03.2022.
//

public protocol WebPortalServiceProtocol: AnyObject {
    init(portalKey: String)

    func subscribe(callBack: @escaping (WebPortalCallback) -> Void)
    func publish(topic: PublishTopic, value: PublishValue)
}

public struct PortalConfig {
    public let name: String
    public let key: String
    public let startDir: String
    public let liveAppId: String?
    public let liveUpdateChannel: String?
    public let isLiveUpdateEnabled: Bool

    public init(
        key: String,
        name: String,
        startDir: String,
        liveAppId: String?,
        liveUpdateChannel: String?,
        isLiveUpdateEnabled: Bool
    ) {
        self.key = key
        self.name = name
        self.startDir = startDir
        self.liveAppId = liveAppId
        self.liveUpdateChannel = liveUpdateChannel
        self.isLiveUpdateEnabled = isLiveUpdateEnabled
    }
}
