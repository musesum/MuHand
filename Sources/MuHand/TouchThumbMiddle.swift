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

open class TouchThumbMiddle {

    var handFlo: LeftRight<HandFlo>
    var handTime: LeftRight<TimeInterval>
    var handTouch: LeftRight<TouchHand>

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

        handFlo.left.trackJoints([.thumbTip, .middleTip], on: true)
        handFlo.right.trackJoints([.thumbTip, .middleTip], on: true)
    }

    public func updateTouch() {

        if handTouch.left.time < handFlo.left.time {
            handTouch.left.time = handFlo.left.time
            let tipsDistance = distance(handFlo.left.thumbTip.xyz,
                                        handFlo.left.middleTip.xyz)
            if tipsDistance < touchTheshold {
                handTouch.left.touching(true, handFlo.left.middleTip.xyz)
            } else {
                handTouch.left.touching(false, handFlo.left.middleTip.xyz)
            }
        }
        if handTouch.right.time < handFlo.right.time {
            handTouch.right.time = handFlo.right.time
            let tipsDistance = distance(handFlo.right.thumbTip.xyz, 
                                        handFlo.right.middleTip.xyz)
            if tipsDistance < touchTheshold {
                handTouch.right.touching(true, handFlo.right.middleTip.xyz)
                //print("🤏", terminator: " ")
            } else {
                handTouch.right.touching(false, handFlo.right.middleTip.xyz)
            }
        }

    }

}
