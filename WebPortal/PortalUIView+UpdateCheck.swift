import IonicLiveUpdates
import IonicPortals
import UIKit

public extension PortalUIView {
    convenience init(portal: Portal, config: PortalConfig) {
        self.init(portal: portal)

        guard config.isLiveUpdateEnabled,
              let liveAppId = config.liveAppId,
              config.syncImmediately
        else {
            return
        }

        checkUpdate(liveAppId: liveAppId, portalView: self, updateManager: LiveUpdateManager.shared)
    }

    private func checkUpdate(liveAppId: String, portalView: PortalUIView, updateManager: LiveUpdateManager) {
        updateManager.sync(appId: liveAppId) { result in
            switch result {
            case let .success(response):
                let latestLiveUpdate = response.liveUpdate
                // Extracting live updates from updateManager apps
                let localLiveUpdates = updateManager.apps.map { $0.value }

                // Checking if the latestLiveUpdate is not contained in localLiveUpdates
                if localLiveUpdates.contains(latestLiveUpdate) == false {
                    // If latestLiveUpdate is not present locally, reload the portal view
                    DispatchQueue.main.async {
                        portalView.reload() // Reload the portal view
                    }
                }
            case .failure:
                // Handle failure case if needed
                break
            }
        }
    }

}
