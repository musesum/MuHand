// created by musesum on 1/22/24
#if os(visionOS)
import UIKit
import ARKit
import simd // distance

public protocol TouchHandPhase {
    func begin(_ touchHand: TouchHand)
    func update(_ touchHand: TouchHand)
}

public class TouchHand {

    var delegate: TouchHandPhase
    var hand: HandAnchor.Chirality

    var phase = UITouch.Phase.ended
    var pos   = SIMD3<Float>.zero
    var time = TimeInterval.zero
    var hash: Int { hand.hashValue }

    public init(_ delegate: TouchHandPhase,
                _ hand: HandAnchor.Chirality) {

        self.delegate = delegate
        self.hand = hand

    }
    public func touching(_ touching: Bool, _ pos: SIMD3<Float>) {
        switch (phase, touching) {

        case (.ended, true):

            self.phase = .began
            self.pos = pos
            delegate.begin(self)

        case (.began, true),
            (.moved, true):

            self.phase = .moved
            self.pos = pos
            delegate.update(self)

        case (.moved, false),
            (.began, false): // tap?

            self.phase = .ended
            self.pos = pos
            delegate.update(self)

        default: return //

        }
    }
}

#endif
