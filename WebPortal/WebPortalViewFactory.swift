//
//  WebPortalViewFactory.swift
//  WebPortal
//
//  Created by Maksym Kravchenko on 18.05.2022.
//

import IonicPortals
import UIKit

public protocol WebPortalViewFactory {
    func createView(config: PortalConfig, initialContext: [String: String], completion: @escaping (UIView) -> Void)
}

public extension WebPortalViewFactory {
    func createView(config: PortalConfig, initialContext: [String: String], completion: @escaping (UIView) -> Void) {
        let portal = Portal(
            initialContext: initialContext,
            config: config
        )

        let portalView = PortalUIView(portal: portal, config: config)
        completion(portalView)
    }
}
