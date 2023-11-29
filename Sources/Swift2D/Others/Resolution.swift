public struct Resolution {
    public let topLeft:  Point
    public let bottomRight: Point

    public init(topLeft: Point, bottomRight: Point) {
        self.topLeft = topLeft
        self.bottomRight = bottomRight
    }
}
