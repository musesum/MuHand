// created by musesum on 1/22/24

#if os(visionOS)

import MuFlo
import ARKit
import MuExtensions

public class HandFlo {
    
    public var time = TimeInterval.zero
    public var jointItems  = [Joint: JointItem]()

    init() {

        jointItems = [
            .thumbKnuckle   : JointItem() ,
            .thumbBase      : JointItem() ,
            .thumbInter     : JointItem() ,
            .thumbTip       : JointItem() ,
            .indexMetacar   : JointItem() ,
            .indexKnuckle   : JointItem() ,
            .indexBase      : JointItem() ,
            .indexInter     : JointItem() ,
            .indexTip       : JointItem() ,
            .middleMetacar  : JointItem() ,
            .middleKnuckle  : JointItem() ,
            .middleBase     : JointItem() ,
            .middleInter    : JointItem() ,
            .middleTip      : JointItem() ,
            .ringMetacar    : JointItem() ,
            .ringKnuckle    : JointItem() ,
            .ringBase       : JointItem() ,
            .ringInter      : JointItem() ,
            .ringTip        : JointItem() ,
            .littleMetacar  : JointItem() ,
            .littleKnuckle  : JointItem() ,
            .littleBase     : JointItem() ,
            .littleInter    : JointItem() ,
            .littleTip      : JointItem() ,
        ]
    }
    public func parseHand(_ hand˚: Flo) {

        let flo = hand˚.bind("joint")
        for (key, value) in self.jointItems {
            value.parse(flo, key)
        }
    }

    public func trackJoints(_ trackJoints: [Joint], on: Bool) {
        for trackJoint in trackJoints {
            if let jointItem = jointItems[trackJoint] {
                jointItem.on = on
            }
        }
    }

    func updateAnchor(_ anchor: HandAnchor) {

        guard let skeleton = anchor.handSkeleton else { return err("skeleton") }

        let transform = anchor.originFromAnchorTransform

        var newUpdate = false

        for (joint, item) in jointItems {
            if item.on,
               let arName = joint.arJoint {

                let jointItems = skeleton.joint(arName)
                item.xyz = matrix_multiply(transform, jointItems.anchorFromJointTransform).columns.3.xyz
                newUpdate = true
            }
        }
        if newUpdate {
            time = Date().timeIntervalSince1970
        }
        MuLog.NoLog("HandFlo", interval: 1.0) {
            var msg = ""
            for (joint, item) in self.jointItems {
                if item.on {
                    msg += joint.rawValue + item.xyz.script + " "
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
