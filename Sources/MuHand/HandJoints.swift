// created by musesum on 1/20/24

#if os(visionOS)
import ARKit

public enum Joint: String {

    case thumbKnuckle   = "thumb.knuckle"
    case thumbBase      = "thumb.base"
    case thumbInter     = "thumb.inter"
    case thumbTip       = "thumb.tip"

    case indexMetacar   = "index.metacar"
    case indexKnuckle   = "index.knuckle"
    case indexBase      = "index.base"
    case indexInter     = "index.inter"
    case indexTip       = "index.tip"

    case middleMetacar  = "middle.metacar"
    case middleKnuckle  = "middle.knuckle"
    case middleBase     = "middle.base"
    case middleInter    = "middle.inter"
    case middleTip      = "middle.tip"

    case ringMetacar    = "ring.metacar"
    case ringKnuckle    = "ring.knuckle"
    case ringBase       = "ring.base"
    case ringInter      = "ring.inter"
    case ringTip        = "ring.tip"

    case littleMetacar  = "little.metacar"
    case littleKnuckle  = "little.knuckle"
    case littleBase     = "little.base"
    case littleInter    = "little.inter"
    case littleTip      = "little.tip"

    var arJoint: HandSkeleton.JointName? {
        ARHandJoint[self] 
    }
    var num: Int {
        switch self {
           
        case .thumbKnuckle  : 1
        case .thumbBase     : 2
        case .thumbInter    : 3
        case .thumbTip      : 4

        case .indexMetacar  : 5
        case .indexKnuckle  : 6
        case .indexBase     : 7
        case .indexInter    : 8
        case .indexTip      : 9

        case .middleMetacar : 10
        case .middleKnuckle : 11
        case .middleBase    : 12
        case .middleInter   : 13
        case .middleTip     : 14

        case .ringMetacar   : 15
        case .ringKnuckle   : 16
        case .ringBase      : 17
        case .ringInter     : 18
        case .ringTip       : 19

        case .littleMetacar : 20
        case .littleKnuckle : 21
        case .littleBase    : 22
        case .littleInter   : 23
        case .littleTip     : 24

        default: 0
        }
    }
}

let ARHandJoint: [Joint: HandSkeleton.JointName] = [

    .thumbKnuckle   : .thumbKnuckle,
    .thumbBase      : .thumbIntermediateBase,
    .thumbInter     : .thumbIntermediateTip,
    .thumbTip       : .thumbTip,
    .indexMetacar   : .indexFingerMetacarpal,
    .indexKnuckle   : .indexFingerKnuckle,
    .indexBase      : .indexFingerIntermediateBase,
    .indexInter     : .indexFingerIntermediateTip,
    .indexTip       : .indexFingerTip,
    .middleMetacar  : .middleFingerMetacarpal,
    .middleKnuckle  : .middleFingerKnuckle,
    .middleBase     : .middleFingerIntermediateBase,
    .middleInter    : .middleFingerIntermediateTip,
    .middleTip      : .middleFingerTip,
    .ringMetacar    : .ringFingerMetacarpal,
    .ringKnuckle    : .ringFingerKnuckle,
    .ringBase       : .ringFingerIntermediateBase,
    .ringInter      : .ringFingerIntermediateTip,
    .ringTip        : .ringFingerTip,
    .littleMetacar  : .littleFingerMetacarpal,
    .littleKnuckle  : .littleFingerKnuckle,
    .littleBase     : .littleFingerIntermediateBase,
    .littleInter    : .littleFingerIntermediateTip,
    .littleTip      : .littleFingerTip,
]
#endif
