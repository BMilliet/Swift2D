public final class Shape {
    public let id: String
    public var matrix: [[Int]]
    public var column: Int
    public var row: Int
    public var points: [Point] = []

    public var lastCollision: CollisionType = .none
    public var lastCollidedShape: String = ""
    public var lastCollidedPoint: Point? = nil

    public init(id: String, matrix: [[Int]], column: Int, row: Int) {
        self.id = id
        self.matrix = matrix
        self.column = column
        self.row = row
    }
}


public struct Point: Hashable {
    let column: Int
    let row: Int
}
