// created by musesum on 1/22/24
#if os(visionOS)
import UIKit
import ARKit
import simd // distance

public protocol TouchHandState {
    func handBegin(_ touchHand: TouchHand)
    func handUpdate(_ touchHand: TouchHand)
}

public class TouchHand {

    private var handState: TouchHandState
    private var hand: HandAnchor.Chirality

    public var phase = UITouch.Phase.ended
    public var pos   = SIMD3<Float>.zero
    public var time = TimeInterval.zero
    public var hash: Int { hand.hashValue }

    public init(_ handState: TouchHandState,
                _ hand: HandAnchor.Chirality) {

        self.handState = handState
        self.hand = hand
    }

    public func touching(_ touching: Bool, 
                         _ pos: SIMD3<Float>) {

        switch (phase, touching) {

        case (.ended, true):

            self.phase = .began
            self.pos = pos
            handState.handBegin(self)

        case (.began, true),
            (.moved, true):

            self.phase = .moved
            self.pos = pos
            handState.handUpdate(self)

        case (.moved, false),
            (.began, false): // tap?

            self.phase = .ended
            self.pos = pos
            handState.handUpdate(self)

        default: return //

        }
    }
}

#endif
