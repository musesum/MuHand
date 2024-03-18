// created by musesum on 1/18/24

import ARKit
import MuFlo
import MuExtensions

open class HandsModel: HandTrackerDelegate{

    @Published var updated: Bool = false

    let handState: TouchHandState
    public let handsFlo = LeftRight<HandFlo>(HandFlo(), HandFlo())
    var touchHands: LeftRight<TouchHand>!
    var touchTheshold = Float(0.02)

    public init(_ handState: TouchHandState,
                _ rootFlo: Flo,
                _ archive: FloArchive) {

        self.handState = handState

        MuHand.parseFlo(rootFlo, "hand")
        let hand = rootFlo.bind("hand")
        handsFlo.left.parseHand( hand.bind("left"))
        handsFlo.right.parseHand( hand.bind("right"))
        
        self.touchHands = LeftRight<TouchHand>(TouchHand(handState, .left),
                                               TouchHand(handState, .right))

        self.handsFlo.left.trackAllJoints(on: true)
        self.handsFlo.right.trackAllJoints(on: true)
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
    public func updateTouch() {

        if touchHands.left.time < handsFlo.left.time {

            touchHands.left.time = handsFlo.left.time
            updateThumb(handsFlo.left, touchHands.left)
        }
        if touchHands.right.time < handsFlo.right.time {

            touchHands.right.time = handsFlo.right.time
            updateThumb(handsFlo.right, touchHands.right)
        }
        updated = true
    }

}
