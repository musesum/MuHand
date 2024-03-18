// created by musesum on 3/17/24

import ARKit
import MuFlo
import MuExtensions

public protocol HandTrackerDelegate {
    func updateTouch()
}

#if os(visionOS)
open class HandsTracker: ObservableObject, @unchecked Sendable {

    let session = ARKitSession()
    var handTracking = HandTrackingProvider()
    let handsFlo: LeftRight<HandFlo>
    let delegate: HandTrackerDelegate

    public init(_ delegate: HandTrackerDelegate,
                _ handsFlo: LeftRight<HandFlo>) {

        self.delegate = delegate
        self.handsFlo = handsFlo

    }
    public func startHands() async {

        do {
            if HandTrackingProvider.isSupported {
                print("ARKitSession starting.")
                try await session.run([handTracking])
            }
        } catch {
            print("ARKitSession error:", error)
        }
    }

    public func updateHands() async {

        for await anchorUpdate in handTracking.anchorUpdates {

            if anchorUpdate.event == .updated,
               anchorUpdate.anchor.isTracked {

                let anchor = anchorUpdate.anchor

                switch anchor.chirality {
                case .left:  handsFlo.left.updateAnchor(anchor)
                case .right: handsFlo.right.updateAnchor(anchor)
                }
            }
            delegate.updateTouch()
        }
    }
    public func monitorSessionEvents() async {
        for await event in session.events {
            switch event {
            case .authorizationChanged(let type, let status):
                if type == .handTracking && status != .allowed {
                    // Achromsk the user to grant hand tracking authorization again in Settings.
                }
            default:
                print("Session event \(event)")
            }
        }
    }
}
#else
/// this is a stub for non-visionOS devices to
/// accept HandTracker events via MuPeer (Bonjour)
#endif
