// created by musesum on 1/18/24

import ARKit
import MuFlo
import MuExtensions

open class HandsModel: ObservableObject, @unchecked Sendable {

    @Published var updated: Bool = false

    let handState: TouchHandState
    let session = ARKitSession()
    var handTracking = HandTrackingProvider()
    let handsFlo: HandsFlo
    var handFlo: LeftRight<HandFlo>!
    var handTime = LeftRight<TimeInterval>(.zero,.zero)
    var handTouch: LeftRight<TouchHand>!
    var touchTheshold = Float(0.02)


    public init(_ handState: TouchHandState,
                _ handFlo: Flo,
                _ archive: FloArchive) {

        self.handState = handState
        self.handsFlo = HandsFlo()
        handsFlo.parseRoot(handFlo, archive)
    }
    public func start() async {

        do {
            if HandTrackingProvider.isSupported {
                print("ARKitSession starting.")
                handFlo   = LeftRight(handsFlo.handFlo[.left]!,
                                      handsFlo.handFlo[.right]!)

                handTouch = LeftRight(TouchHand(handState, .left),
                                      TouchHand(handState, .right))

                handFlo.left.trackAllJoints(on: true)
                handFlo.right.trackAllJoints(on: true)

                try await session.run([handTracking])
            }
        } catch {
            print("ARKitSession error:", error)
        }
    }

    public func updateHands() async {

        for await handUpdate in handTracking.anchorUpdates {

            if handUpdate.event == .updated,
               handUpdate.anchor.isTracked {

                handsFlo.updateHand(handUpdate.anchor.chirality, handUpdate.anchor)
                updated = true
            }
            updateTouch()
        }
    }

    func updateThumb(_ handFlo: HandFlo,
                            _ handTouch: TouchHand) {
        let tipsDistance = distance(handFlo.thumbTip.pos,
                                    handFlo.middleTip.pos)
        if tipsDistance < touchTheshold {
            handTouch.touching(true, handFlo.middleTip.pos)
        } else {
            handTouch.touching(false, handFlo.middleTip.pos)
        }

    }
    func updateTouch() {

        if handTouch.left.time < handFlo.left.time {
            handTouch.left.time = handFlo.left.time
            updateThumb(handFlo.left, handTouch.left)
        }
        if handTouch.right.time < handFlo.right.time {
            handTouch.right.time = handFlo.right.time
            updateThumb(handFlo.right, handTouch.right)
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
