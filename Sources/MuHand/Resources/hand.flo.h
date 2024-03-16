hand.{ left right }.{
    joint {
        thumb  {      knuc base inter tip }.{ pos(x -0.3…0.3, y 0.8…1.2, z -0.5…0.01) on(0…1) }
        index  { meta knuc base inter tip }.{ pos(x -0.3…0.3, y 0.8…1.2, z -0.5…0.01) on(0…1) }
        middle { meta knuc base inter tip }.{ pos(x -0.3…0.3, y 0.8…1.2, z -0.5…0.01) on(0…1) }
        ring   { meta knuc base inter tip }.{ pos(x -0.3…0.3, y 0.8…1.2, z -0.5…0.01) on(0…1) }
        little { meta knuc base inter tip }.{ pos(x -0.3…0.3, y 0.8…1.2, z -0.5…0.01) on(0…1) }
        wrist { pos(x -0.3…0.3, y 0.8…1.2, z -0.5…0.01) on(0…1) }
        forearm { pos(x -0.3…0.3, y 0.8…1.2, z -0.5…0.01) on(0…1) }
    }
    touch {
        thumb {
            index   { tip inter base }.{ pos(x -0.3…0.3, y 0.8…1.2, z -0.5…0.01)  on(0…1) }
            middle  { tip inter base }.{ pos(x -0.3…0.3, y 0.8…1.2, z -0.5…0.01)  on(0…1) }
            ring    { tip inter base }.{ pos(x -0.3…0.3, y 0.8…1.2, z -0.5…0.01)  on(0…1) }
            little  { tip inter base }.{ pos(x -0.3…0.3, y 0.8…1.2, z -0.5…0.01)  on(0…1) }
        }
        index @ joint // index finger of opposing hand touching joint to toggle on/off
    }
}
