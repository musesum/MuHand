// created by musesum on 3/16/24

#if os(visionOS)

import MuFlo
import ARKit
import MuExtensions

extension HandFlo {

    func updateAnchor(_ anchor: HandAnchor) {

        guard let skeleton = anchor.handSkeleton else { return err("skeleton") }

        let transform = anchor.originFromAnchorTransform

        var newUpdate = false

        for (joints, item) in joints {
            if item.on,
               let arName = joints.arJoint {

                let joints = skeleton.joint(arName)
                item.pos = matrix_multiply(transform, joints.anchorFromJointTransform).columns.3.xyz
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
                    msg += joints.rawValue + item.pos.script(-2) + " "
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
