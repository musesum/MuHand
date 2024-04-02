// created by musesum on 3/19/24

import UIKit
import MuFlo
import MuExtensions
import simd

public class JointCanvasFlo: JointFlo {

    var touchCanvas: TouchCanvasDelegate?
    
    func parseCanvas(_ touchCanvas: TouchCanvasDelegate,
                     _ chiral: Chiral,
                     _ parent˚: Flo) {

        self.touchCanvas = touchCanvas
        self.joint = .canvas
        self.chiral = chiral

        flo˚ = parent˚.bind(joint.name) { val,_ in
            self.pos = val.xyz
            guard let time  = val.double(named: "time" ) else { return err("time") }
            guard let joint = val.double(named: "joint") else { return err("joint") }
            guard let phase = val.phase (named: "phase") else { return err("phase") }

            self.time = time
            self.joint = JointEnum(rawValue: Int(joint))
            self.phase = phase

            switch self.phase {
            case .began: self.touchCanvas?.handBegin(self)
            default:     self.touchCanvas?.handUpdate(self)
            }
        }
        if flo˚ == nil { err("flo˚") }
        func err(_ msg: String) {
            print("⁉️ JointCanvasFlo::\(#function) \(flo˚?.path() ?? "").\(msg) not Found")
        }
    }

}