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
    let name: String
    let key: String
    let startDir: String
    let liveAppId: String?
    let liveUpdateChannel: String?
    let isLiveUpdateEnabled: Bool
    let syncImmediately: Bool

    public init(
        key: String,
        name: String,
        startDir: String,
        liveAppId: String?,
        liveUpdateChannel: String?,
        isLiveUpdateEnabled: Bool,
        syncImmediately: Bool = false
    ) {
        self.key = key
        self.name = name
        self.startDir = startDir
        self.liveAppId = liveAppId
        self.liveUpdateChannel = liveUpdateChannel
        self.isLiveUpdateEnabled = isLiveUpdateEnabled
        self.syncImmediately = syncImmediately
    }
}
