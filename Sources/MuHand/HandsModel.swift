// created by musesum on 1/18/24

#if os(visionOS)

import ARKit
import MuExtensions

public class HandsUpdate {
    var left: HandAnchor?
    var right: HandAnchor?
}

open class HandsModel: ObservableObject, @unchecked Sendable {

    @Published var handsUpdate = HandsUpdate()

    let handDelebate: TouchHandDelegate
    let session = ARKitSession()
    var handTracking = HandTrackingProvider()
    public let handsFlo = HandsFlo()

    //TODO: refactor this as a protocol
    var thumbMiddle: TouchThumbMiddle?

    public init(_ handDelegate: TouchHandDelegate) {
        self.handDelebate = handDelegate
    }
    public func start() async {

        do {
            if HandTrackingProvider.isSupported {
                print("ARKitSession starting.")
                thumbMiddle = TouchThumbMiddle(handDelebate, handsFlo)
                try await session.run([handTracking])
            }
        } catch {
            print("ARKitSession error:", error)
        }
    }

    public func publishHandTrackingUpdates() async {

        for await update in handTracking.anchorUpdates {

            if update.event == .updated,
               update.anchor.isTracked {

                handsFlo.updateHand(update.anchor.chirality, update.anchor)

                switch update.anchor.chirality {
                case .left  : handsUpdate.left  = update.anchor
                case .right : handsUpdate.right = update.anchor
                }
            }
            thumbMiddle?.updateTouch()
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
