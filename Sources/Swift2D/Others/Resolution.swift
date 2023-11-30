public struct Resolution {
    var topLeft:  Point
    var bottomRight: Point

    init(topLeft: Point, bottomRight: Point) {
        self.topLeft = topLeft
        self.bottomRight = bottomRight
    }
}
