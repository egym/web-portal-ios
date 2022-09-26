//
//  WebPortalViewFactory.swift
//  WebPortal
//
//  Created by Maksym Kravchenko on 18.05.2022.
//

import IonicPortals
import IonicLiveUpdates
import UIKit

public protocol WebPortalViewFactory {
    func createView(config: PortalConfig, initialContext: [String: String]) -> UIView?
}

public extension WebPortalViewFactory {
    func createView(config: PortalConfig, initialContext: [String: String]) -> UIView? {
        let liveUpdateConfig: LiveUpdate?
        if config.isLiveUpdateEnabled,
            let liveAppId = config.liveAppId,
            let liveUpdateChannel = config.liveUpdateChannel {
            liveUpdateConfig = LiveUpdate(appId: liveAppId, channel: liveUpdateChannel)
        } else {
            liveUpdateConfig = nil
        }

        let portal = Portal(
            name: config.name,
            startDir: config.startDir,
            initialContext: initialContext,
            liveUpdateConfig: liveUpdateConfig
        )

        return PortalUIView(portal: portal)
    }
}
