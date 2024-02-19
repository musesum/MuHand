// created by musesum on 1/19/24
#if os(visionOS)
import MuFlo
import ARKit

public class MuHandsFlo {

    public static let shared = MuHandsFlo()
    public let root = Flo("√")
    private var archive : FloArchive?

    public var handFlo: [HandAnchor.Chirality: HandFlo] = [.left: HandFlo(),
                                                           .right: HandFlo()]

    public var leftHand = HandFlo()
    public var rightHand = HandFlo()
    
    private var scriptNames = ["corner", "hands", "menu"]

    public init() {
        parseScriptFiles()
    }

    func parseScriptFiles() {
        for name in scriptNames {
            MuMenuHands.parseFlo(root, name)
        }
    }
    public func parseRoot(_ root: Flo,
                          _ archive: FloArchive) {

        let hand = root.bind("hand")
        handFlo[.left]?.parseHand( hand.bind("left"))
        handFlo[.right]?.parseHand( hand.bind("right"))
        //???? print(hand.scriptFull)
    }
    public func setHand(_ chirality: HandAnchor.Chirality, finger: [Joint], on: Bool) {
        handFlo[chirality]?.trackJoints(finger, on: on)
    }
    public func updateHand(_ chirality: HandAnchor.Chirality, 
                           _ anchor: HandAnchor) {
        handFlo[chirality]?.updateAnchor(anchor)
    }
}

#endif

// (2 hands * 4 fingers * 3 finger) => 24 control points =>
// 24 * (tap, tap2, hold, swipe) => 96 discreet gestures
// (24 xyz controllers + 8 slidders) => 80 conintuous paramaters
//
// so 96 modes * 80 continuos parameters =>
//     3840 modal continuous parameters with one hand
//     7680 modal continuos parameters with boths hands
//
// Use other hand to interogate by touching joint
// other hand dit-dit-dit-dah (V) to bind to menu leaf
// ASL Trainable
