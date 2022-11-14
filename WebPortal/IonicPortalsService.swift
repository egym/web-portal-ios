//
//  IonicPortalsService.swift
//  WebPortal
//
//  Created by Maksym Kravchenko on 01.03.2022.
//

import Capacitor
import Combine
import IonicPortals

public class IonicPortalsService: WebPortalServiceProtocol {
    private let subscriptionKey = "subscription"
    private var cancellable: AnyCancellable?

    required public init(portalKey: String) {
        PortalsRegistrationManager.shared.register(key: portalKey)
    }

    public func subscribe(callBack: @escaping (WebPortalCallback) -> Void) {
        assert(cancellable == nil, "\(#function) should be called once")

        cancellable = PortalsPubSub.subscribe(to: subscriptionKey) { result in
            guard let typeString = (result.data as? [String: Any])?["type"] as? String,
                  let callbackType = CallbackType(rawValue: typeString) else {
                      return
                  }

            let callBackValue: WebPortalCallback
            if let dict = (result.data as? [String: Any])?["data"] as? [String: Any] {
                callBackValue = WebPortalCallback(type: callbackType, data: dict)
            } else {
                callBackValue = WebPortalCallback(type: callbackType, data: nil)
            }

            DispatchQueue.main.async {
                callBack(callBackValue)
            }
        }
    }

    public func publish(topic: PublishTopic, value: PublishValue) {
        switch value {
        case .codable(let codable):
            if let value = codable as? JSValue {
                PortalsPubSub.publish(value, to: topic.rawValue)
            } else {
                guard
                    let data = try? JSONEncoder().encode(codable),
                    let encodedStringData = String(data: data, encoding: .utf8)
                else {
                    return
                }

                PortalsPubSub.publish(encodedStringData, to: topic.rawValue)
            }
        case .data(let data):
            guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                    let value = dictionary as? JSValue else {
                return
            }
            PortalsPubSub.publish(value, to: topic.rawValue)
        }
    }
}
