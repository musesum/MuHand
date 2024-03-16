// created by musesum on 1/18/24

#if os(visionOS)

import ARKit
import MuExtensions

open class HandsModel: ObservableObject, @unchecked Sendable {

    @Published var updated: Bool = false

    let handState: TouchHandState
    let session = ARKitSession()
    var handTracking = HandTrackingProvider()
    public let handsFlo = MuHandsFlo()

    //TODO: refactor this as a protocol
    var touchJoints: TouchJoints?

    public init(_ handState: TouchHandState) {
        self.handState = handState
    }
    public func start() async {

        do {
            if HandTrackingProvider.isSupported {
                print("ARKitSession starting.")
                touchJoints = TouchJoints(handState, handsFlo)
                try await session.run([handTracking])
            }
        } catch {
            print("ARKitSession error:", error)
        }
    }

    public func publishHandTrackingUpdates() async {

        for await handUpdate in handTracking.anchorUpdates {

            if handUpdate.event == .updated,
               handUpdate.anchor.isTracked {

                handsFlo.updateHand(handUpdate.anchor.chirality, handUpdate.anchor)
                updated = true
            }
            touchJoints?.updateTouch()
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
#endif
