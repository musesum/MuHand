// created by musesum on 1/22/24

import ARKit

class LeftRight<T> {
    var left: T
    var right: T
    init(_ left: T, _ right: T) {
        self.left = left
        self.right = right
    }
}

open class TouchJoints {

    var handFlo: LeftRight<HandFlo>
    var handTime: LeftRight<TimeInterval>
    var handTouch: LeftRight<TouchHand>

//    var thumbTouch: LeftRight<Joint?>
//    var indexTouch: LeftRight<Joint?> // touching other hand joint
//
    var handState: TouchHandState
    var touchTheshold = Float(0.02)

    public init(_ handState: TouchHandState,
                _ handsFlo: MuHandsFlo) {

        handFlo   = LeftRight(handsFlo.handFlo[.left]!,
                              handsFlo.handFlo[.right]!)

        handTime  = LeftRight(.zero, .zero)

        handTouch = LeftRight(TouchHand(handState, .left),
                              TouchHand(handState, .right))

        self.handState = handState

        handFlo.left.trackAllJoints(on: true)
        handFlo.right.trackAllJoints(on: true)
    }

    public func updateThumb(_ handFlo: HandFlo,
                            _ handTouch: TouchHand) {
        let tipsDistance = distance(handFlo.thumbTip.xyz,
                                    handFlo.middleTip.xyz)
        if tipsDistance < touchTheshold {
            handTouch.touching(true, handFlo.middleTip.xyz)
        } else {
            handTouch.touching(false, handFlo.middleTip.xyz)
        }

    }
    public func updateTouch() {

        if handTouch.left.time < handFlo.left.time {
            handTouch.left.time = handFlo.left.time
            updateThumb(handFlo.left, handTouch.left)
        }
        if handTouch.right.time < handFlo.right.time {
            handTouch.right.time = handFlo.right.time
            updateThumb(handFlo.right, handTouch.right)
        }

    }

}
