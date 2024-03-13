// created by musesum on 1/20/24

#if os(visionOS)

import MuFlo
import MuExtensions

public class JointItem {

    var flo˚ : Flo?
    var xyz˚ : Flo? ; public var xyz = SIMD3<Float>.zero
    var on˚  : Flo? ; public var on = false

    func parse(_ hand˚: Flo, _ joints: Joint) {

        flo˚ = hand˚.bind(joints.rawValue)
        xyz˚ = flo˚?.bind("pos") { f,_ in self.xyz = f.xyz  }
        on˚  = flo˚?.bind("on")  { f,_ in self.on  = f.bool }

        guard let flo˚ else { return err("\(joints.rawValue)") }
        if xyz˚ == nil      { return err("\(flo˚.name).xyz") }
        if on˚  == nil      { return err("\(flo˚.name).on") }

        func err(_ msg: String) {
            print("⁉️ hand.\(joints.rawValue) not Found")
        }
    }
}
#endif
