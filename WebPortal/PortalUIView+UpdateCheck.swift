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
        updateManager.checkForUpdate(appId: liveAppId) { result in
            switch result {
            case let .success(response):
                if let snapshotId = response.data.snapshot {
                    let localSnapshotsIds = updateManager.getAppSnapshots(for: liveAppId).map { $0.id }
                    if localSnapshotsIds.contains(snapshotId) == false {
                        updateManager.sync(appId: liveAppId) { _ in
                            DispatchQueue.main.async {
                                portalView.reload()
                            }
                        }
                    }
                }
            case .failure:
                // in case of failure, static view was already presented in the completion
                break
            }
        }
    }
}
