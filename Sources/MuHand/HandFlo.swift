// created by musesum on 1/22/24

import MuFlo
import ARKit
import MuExtensions

public class HandFlo {

    public var time = TimeInterval.zero
    public var joints = [HandJoint: JointFlo]()
    public var touchIndex = [HandJoint: JointFlo]()
    public var touchThumb = [HandJoint: JointFlo]()

    // joints from arkit
    var thumbKnuc   = JointFlo()
    var thumbBase   = JointFlo()
    var thumbInter  = JointFlo()
    var thumbTip    = JointFlo()
    var indexMeta   = JointFlo()
    var indexKnuc   = JointFlo()
    var indexBase   = JointFlo()
    var indexInter  = JointFlo()
    var indexTip    = JointFlo()
    var middleMeta  = JointFlo()
    var middleKnuc  = JointFlo()
    var middleBase  = JointFlo()
    var middleInter = JointFlo()
    var middleTip   = JointFlo()
    var ringMeta    = JointFlo()
    var ringKnuc    = JointFlo()
    var ringBase    = JointFlo()
    var ringInter   = JointFlo()
    var ringTip     = JointFlo()
    var littleMeta  = JointFlo()
    var littleKnuc  = JointFlo()
    var littleBase  = JointFlo()
    var littleInter = JointFlo()
    var littleTip   = JointFlo()
    var wrist       = JointFlo()
    var forearm     = JointFlo()

    // index finger touching joint of opposite hand
    var indexThumbKnuc   = JointFlo()
    var indexThumbBase   = JointFlo()
    var indexThumbInter  = JointFlo()
    var indexThumbTip    = JointFlo()
    var indexIndexMeta   = JointFlo()
    var indexIndexKnuc   = JointFlo()
    var indexIndexBase   = JointFlo()
    var indexIndexInter  = JointFlo()
    var indexIndexTip    = JointFlo()
    var indexMiddleMeta  = JointFlo()
    var indexMiddleKnuc  = JointFlo()
    var indexMiddleBase  = JointFlo()
    var indexMiddleInter = JointFlo()
    var indexMiddleTip   = JointFlo()
    var indexRingMeta    = JointFlo()
    var indexRingKnuc    = JointFlo()
    var indexRingBase    = JointFlo()
    var indexRingInter   = JointFlo()
    var indexRingTip     = JointFlo()
    var indexLittleMeta  = JointFlo()
    var indexLittleKnuc  = JointFlo()
    var indexLittleBase  = JointFlo()
    var indexLittleInter = JointFlo()
    var indexLittleTip   = JointFlo()
    var indexWrist       = JointFlo()
    var indexForearm     = JointFlo()

    // thumb touch finger of same hand
    var thumbIndexBase   = JointFlo()
    var thumbIndexInter  = JointFlo()
    var thumbIndexTip    = JointFlo()
    var thumbMiddleBase  = JointFlo()
    var thumbMiddleInter = JointFlo()
    var thumbMiddleTip   = JointFlo()
    var thumbRingBase    = JointFlo()
    var thumbRingInter   = JointFlo()
    var thumbRingTip     = JointFlo()
    var thumbLittleBase  = JointFlo()
    var thumbLittleInter = JointFlo()
    var thumbLittleTip   = JointFlo()

    public init() {

        joints = [
            .thumbKnuc   : thumbKnuc   ,
            .thumbBase   : thumbBase   ,
            .thumbInter  : thumbInter  ,
            .thumbTip    : thumbTip    ,
            .indexMeta   : indexMeta   ,
            .indexKnuc   : indexKnuc   ,
            .indexBase   : indexBase   ,
            .indexInter  : indexInter  ,
            .indexTip    : indexTip    ,
            .middleMeta  : middleMeta  ,
            .middleKnuc  : middleKnuc  ,
            .middleBase  : middleBase  ,
            .middleInter : middleInter ,
            .middleTip   : middleTip   ,
            .ringMeta    : ringMeta    ,
            .ringKnuc    : ringKnuc    ,
            .ringBase    : ringBase    ,
            .ringInter   : ringInter   ,
            .ringTip     : ringTip     ,
            .littleMeta  : littleMeta  ,
            .littleKnuc  : littleKnuc  ,
            .littleBase  : littleBase  ,
            .littleInter : littleInter ,
            .littleTip   : littleTip   ,
            .wrist       : wrist       ,
            .forearm     : forearm     ,
        ]
        touchIndex = [
            .thumbKnuc   : indexThumbKnuc   ,
            .thumbBase   : indexThumbBase   ,
            .thumbInter  : indexThumbInter  ,
            .thumbTip    : indexThumbTip    ,
            .indexMeta   : indexIndexMeta   ,
            .indexKnuc   : indexIndexKnuc   ,
            .indexBase   : indexIndexBase   ,
            .indexInter  : indexIndexInter  ,
            .indexTip    : indexIndexTip    ,
            .middleMeta  : indexMiddleMeta  ,
            .middleKnuc  : indexMiddleKnuc  ,
            .middleBase  : indexMiddleBase  ,
            .middleInter : indexMiddleInter ,
            .middleTip   : indexMiddleTip   ,
            .ringMeta    : indexRingMeta    ,
            .ringKnuc    : indexRingKnuc    ,
            .ringBase    : indexRingBase    ,
            .ringInter   : indexRingInter   ,
            .ringTip     : indexRingTip     ,
            .littleMeta  : indexLittleMeta  ,
            .littleKnuc  : indexLittleKnuc  ,
            .littleBase  : indexLittleBase  ,
            .littleInter : indexLittleInter ,
            .littleTip   : indexLittleTip   ,
            .wrist       : indexWrist       ,
            .forearm     : indexForearm     ,
        ]
        touchThumb = [
            .indexBase   : thumbIndexBase   ,
            .indexInter  : thumbIndexInter  ,
            .indexTip    : thumbIndexTip    ,
            .middleBase  : thumbMiddleBase  ,
            .middleInter : thumbMiddleInter ,
            .middleTip   : thumbMiddleTip   ,
            .ringBase    : thumbRingBase    ,
            .ringInter   : thumbRingInter   ,
            .ringTip     : thumbRingTip     ,
            .littleBase  : thumbLittleBase  ,
            .littleInter : thumbLittleInter ,
            .littleTip   : thumbLittleTip   ,
        ]
    }
    public func parseHand(_ hand˚: Flo) {

        let handJoint = hand˚.bind("joint")
        for (key, value) in self.joints {
            value.parse(handJoint, key)
        }
        let touchThumb = hand˚.bind("touch.thumb")
        for (key, value) in self.touchThumb {
            value.parse(touchThumb, key)
        }
        let touchIndex = hand˚.bind("touch.index")
        for (key, value) in self.touchIndex {
            value.parse(touchIndex, key)
        }
    }

    public func trackAllJoints(on: Bool) {
        for jointItem in joints.values {
            jointItem.on = on
        }
    }

    public func trackJoints(_ trackJoints: [HandJoint], on: Bool) {
        for trackJoint in trackJoints {
            if let jointItem = joints[trackJoint] {
                jointItem.on = on
            }
        }
    }

}


