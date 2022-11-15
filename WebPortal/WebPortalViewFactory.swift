//
//  WebPortalViewFactory.swift
//  WebPortal
//
//  Created by Maksym Kravchenko on 18.05.2022.
//

import IonicLiveUpdates
import IonicPortals
import UIKit

public protocol WebPortalViewFactory {
    func createView(config: PortalConfig, initialContext: [String: String], completion: @escaping (UIView) -> Void)
}

public extension WebPortalViewFactory {
    func createView(config: PortalConfig, initialContext: [String: String], completion: @escaping (UIView) -> Void) {
        if config.isLiveUpdateEnabled,
           let liveAppId = config.liveAppId,
           let liveUpdateChannel = config.liveUpdateChannel
        {
            guard config.syncImmediately else {
                let liveUpdateConfig = LiveUpdate(appId: liveAppId, channel: liveUpdateChannel)
                let portal = Portal(
                    name: config.name,
                    startDir: config.startDir,
                    initialContext: initialContext,
                    liveUpdateConfig: liveUpdateConfig
                )
                completion(PortalUIView(portal: portal))
                return
            }

            let updateManager = LiveUpdateManager.shared
            let liveUpdateConfig = LiveUpdate(
                appId: liveAppId,
                channel: liveUpdateChannel,
                syncOnAdd: false
            )

            try? updateManager.add(liveUpdateConfig)
            let portal = Portal(
                name: config.name,
                startDir: config.startDir,
                initialContext: initialContext,
                liveUpdateManager: updateManager,
                liveUpdateConfig: liveUpdateConfig
            )

            let portalView = PortalUIView(portal: portal)
            // Show static content while loading new update if available
            completion(portalView)

            if config.syncImmediately {
                updateManager.sync(appId: liveAppId) { _ in
                    DispatchQueue.main.async {
                        portalView.reload()
                    }
                }
            }
        }
        // Live update is disabled, create static view from `startDir`
        else {
            let portal = Portal(
                name: config.name,
                startDir: config.startDir,
                initialContext: initialContext
            )

            completion(
                PortalUIView(
                    portal: portal
                )
            )
        }
    }
}
