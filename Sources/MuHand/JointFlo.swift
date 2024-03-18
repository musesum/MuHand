// created by musesum on 1/20/24


import MuFlo
import MuExtensions

public class JointFlo {

    var flo˚ : Flo?
    var pos˚ : Flo? ; public var pos = SIMD3<Float>.zero
    var on˚  : Flo? ; public var on = false

    func parse(_ hand˚: Flo, _ joint: HandJoint) {

        flo˚ = hand˚.bind(joint.rawValue)
        pos˚ = flo˚?.bind("pos") { f,_ in self.pos = f.xyz  }
        on˚  = flo˚?.bind("on")  { f,_ in self.on  = f.bool }

        guard let flo˚ else { return err("\(joint.rawValue)") }
        if pos˚ == nil      { return err("\(flo˚.name).pos") }
        if on˚  == nil      { return err("\(flo˚.name).on") }

        func err(_ msg: String) {
            print("⁉️ hand.\(joint.rawValue) not Found")
        }
    }
}
