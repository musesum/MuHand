// created by musesum on 1/22/24

#if os(visionOS)

import MuFlo
import ARKit
import MuExtensions

public class HandFlo {

    public var time = TimeInterval.zero
    public var joints = [Joint: JointItem]()
    public var fingerTips = [Joint: JointItem]()


    var thumbKnuc   = JointItem()
    var thumbBase   = JointItem()
    var thumbInter  = JointItem()
    var thumbTip    = JointItem()
    var indexMeta   = JointItem()
    var indexKnuc   = JointItem()
    var indexBase   = JointItem()
    var indexInter  = JointItem()
    var indexTip    = JointItem()
    var middleMeta  = JointItem()
    var middleKnuc  = JointItem()
    var middleBase  = JointItem()
    var middleInter = JointItem()
    var middleTip   = JointItem()
    var ringMeta    = JointItem()
    var ringKnuc    = JointItem()
    var ringBase    = JointItem()
    var ringInter   = JointItem()
    var ringTip     = JointItem()
    var littleMeta  = JointItem()
    var littleKnuc  = JointItem()
    var littleBase  = JointItem()
    var littleInter = JointItem()
    var littleTip   = JointItem()

    init() {

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
        ]
        fingerTips = [
            .thumbTip  : thumbTip ,
            .indexTip  : indexTip ,
            .middleTip : middleTip,
            .ringTip   : ringTip  ,
            .littleTip : littleTip
        ]
    }
    public func parseHand(_ hand˚: Flo) {

        let flo = hand˚.bind("joint")
        for (key, value) in self.joints {
            value.parse(flo, key)
        }
    }

    public func trackJoints(_ trackJoints: [Joint], on: Bool) {
        for trackJoint in trackJoints {
            if let jointItem = joints[trackJoint] {
                jointItem.on = on
            }
        }
    }

    func updateAnchor(_ anchor: HandAnchor) {

        guard let skeleton = anchor.handSkeleton else { return err("skeleton") }

        let transform = anchor.originFromAnchorTransform

        var newUpdate = false

        for (joints, item) in joints {
            if item.on,
               let arName = joints.arJoint {

                let joints = skeleton.joint(arName)
                item.xyz = matrix_multiply(transform, joints.anchorFromJointTransform).columns.3.xyz
                newUpdate = true
            }
        }
        if newUpdate {
            time = Date().timeIntervalSince1970
        }
        MuLog.Log("HandFlo", interval: 2.0, terminator: " ") {
            var msg = ""
            for (joints, item) in self.joints {
                if item.on {
                    msg += joints.rawValue + item.xyz.script(-2) + " "
                }
            }
            if !msg.isEmpty {
                print("🖐️" + msg)
            }
        }
        func err(_ msg: String) { print("HandPos::update err: \(msg)") }
    }

}

#endif
