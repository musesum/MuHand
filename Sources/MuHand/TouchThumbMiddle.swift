// created by musesum on 1/22/24
#if os(visionOS)
import ARKit

open class TouchThumbMiddle {

    var leftHand: HandFlo
    var rightHand: HandFlo
    var timeLeft = TimeInterval.zero
    var timeRight = TimeInterval.zero
    var touchLeft: TouchHand
    var touchRight: TouchHand
    var touchPhase: TouchHandDelegate
    var touchTheshold = Float(0.02)


    public init(_ touchPhase: TouchHandDelegate,
                _ handsFlo: MuHandsFlo) {

        self.touchPhase = touchPhase
        self.touchLeft = TouchHand(touchPhase, .left)
        self.touchRight = TouchHand(touchPhase, .right)

        self.leftHand = handsFlo.handFlo[.left]!
        self.rightHand = handsFlo.handFlo[.right]!
        leftHand.trackJoints([.thumbTip, .middleTip], on: true)
        rightHand.trackJoints([.thumbTip, .middleTip], on: true)
    }

    public func updateTouch() {

        if touchLeft.time < leftHand.time {
            touchLeft.time = leftHand.time
            if let thumbTip = leftHand.jointItems[.thumbTip]?.xyz,
               let middleTip = leftHand.jointItems[.middleTip]?.xyz {
                let tipsDistance = distance(thumbTip, middleTip)
                if tipsDistance < touchTheshold {
                    touchLeft.touching(true, middleTip)
                } else {
                    touchLeft.touching(false, middleTip)
                }
            }
        }
        if touchRight.time < rightHand.time {
            touchRight.time = rightHand.time
            if let thumbTip = rightHand.jointItems[.thumbTip]?.xyz,
               let middleTip = rightHand.jointItems[.middleTip]?.xyz {
                let tipsDistance = distance(thumbTip, middleTip)
                if tipsDistance < touchTheshold {
                    touchRight.touching(true, middleTip)
                    //print("🤏", terminator: " ")
                } else {
                    touchRight.touching(false, middleTip)
                }
            }

        }

    }

}

#endif
