import Capacitor
import IonicLiveUpdates
import IonicPortals

public extension Portal {
    init(
        initialContext: JSObject = [:],
        config: PortalConfig
    ) {
        if config.isLiveUpdateEnabled,
           let liveAppId = config.liveAppId,
           let liveUpdateChannel = config.liveUpdateChannel
        {
            guard config.syncImmediately else {
                let liveUpdateConfig = LiveUpdate(appId: liveAppId, channel: liveUpdateChannel)
                self = Portal(
                    name: config.name,
                    startDir: config.startDir,
                    initialContext: initialContext,
                    liveUpdateConfig: liveUpdateConfig
                )

                return
            }

            let updateManager = LiveUpdateManager.shared
            let liveUpdateConfig = LiveUpdate(
                appId: liveAppId,
                channel: liveUpdateChannel,
                syncOnAdd: false
            )

            try? updateManager.add(liveUpdateConfig)

            self = Portal(
                name: config.name,
                startDir: config.startDir,
                initialContext: initialContext,
                liveUpdateManager: updateManager,
                liveUpdateConfig: liveUpdateConfig
            )
        }
        else {
            self = Portal(
                name: config.name,
                startDir: config.startDir,
                initialContext: initialContext
            )
        }
    }
}
