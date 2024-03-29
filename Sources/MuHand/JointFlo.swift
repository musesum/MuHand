// created by musesum on 1/20/24

import Foundation
import UIKit
import MuFlo
import MuExtensions
import simd

public protocol TouchCanvasDelegate {
    func handBegin(_ jointFlo: JointFlo)
    func handUpdate(_ jointFlo: JointFlo)
}

public class JointFlo {
    
    let id = Visitor.nextId() //?????
    var flo˚: Flo?
    var on = true  // is this tracked?
    var touching = false
    var timeBegin = TimeInterval(0)
    var timeEnded = TimeInterval(0)
    var tapThreshold = TimeInterval(0.25)

    var chiral: Chiral!
    var joint: JointEnum!

    var touchTheshold = Float(0.015)

    public var pos = SIMD3<Float>.zero
    public var time = TimeInterval(0)
    public var phase = UITouch.Phase.ended

    public var hash: Int { chiral.rawValue * 1000 + joint.rawValue }

    func parse(_ chiral: Chiral, _ hand˚: Flo, _ joint: JointEnum) {

        self.chiral = chiral
        self.joint = joint

        flo˚ = hand˚.bind(joint.name) { val,_ in

            self.pos = val.xyz
            guard let time  = val.double(named: "time") else { return err("time") }
            guard let phase = val.phase(named: "phase") else { return err("phase") }

            self.time = time
            self.phase = phase
        }
        if flo˚ == nil { err("flo˚") }
        func err(_ msg: String) {
            print("⁉️ JointFlo::\(#function) \(flo˚?.path() ?? "").\(msg) not Found")
        }
    }
    /// index finger tip toogles on/off
    func updateIndexTip(_ indexTip: JointFlo) {
        let d = distance(indexTip.pos, pos)
        if  d < touchTheshold {
            if !touching {
                touching = true
                timeBegin = Date().timeIntervalSince1970
            }
        } else {
            if touching {
                touching = false
                timeEnded = Date().timeIntervalSince1970
                let timeDelta = timeEnded - timeBegin
                if timeDelta < tapThreshold {
                    on = !on
                    log()
                }
            }
        }
        func log() {
            let path = "\(chiral.name).\(flo˚?.path() ?? "??")".pad(18)
            let mine = path + pos.script(-2)
            let index = "indexTip\(indexTip.pos.script(-2))"
            print("\(mine) ∆ \(index) => \(d.digits(3)) ")
        }
    }
    /// thumb finger tip as continuos controller or brush
    func updateThumbTip(_ thumbTip: JointFlo) {

        let d = distance(thumbTip.pos, pos)
        if d < touchTheshold {
            switch phase {
            case .began: updateFlo(.moved)
            case .moved: updateFlo(.moved)
            default:     updateFlo(.began); log()
            }
        } else {
            switch phase {
            case .began: updateFlo(.ended)
            case .moved: updateFlo(.ended)
            default:     break
            }
        }
        func log() {
            let path = "\(chiral.name).\(flo˚?.path() ?? "??")".pad(18)
            let mine = path + self.pos.script(-2)
            let thumb = "thumbTip\(thumbTip.pos.script(-2))"
            print("\(mine) ∆ \(thumb) => \(d.digits(3)) ")
        }
    }

    func updatePos(_ pos: SIMD3<Float>) async {
        self.pos = pos
        updateFlo(phase,.sneak)
    }

    func updateFlo(_ phase: UITouch.Phase,
                   time: TimeInterval = Date().timeIntervalSince1970,
                   _ options: FloSetOps = .activate) {
        self.phase = phase
        self.time = time
        let parms: [(String,Double)] = [
            ("x"    , Double(pos.x)),
            ("y"    , Double(pos.y)),
            ("z"    , Double(pos.z)),
            ("time" , Double(time )),
            ("phase", Double(phase.rawValue)),
            ("joint", Double(joint.rawValue))]

        flo˚?.setDoubles(parms)
        if options == .activate {
            flo˚?.activate(Visitor(0))
        }

    }
}


