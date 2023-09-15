public final class Shape {
    public let id: String
    public var matrix: [[Int]]
    public var column: Int
    public var row: Int
    public var points: [Point] = []


    public var lastCollision: CollisionType = .none
    public var lastCollidedShape: String = ""
    public var lastCollidedPoint: Point? = nil
    public var lastRelativeCollisionPoint: Point? = nil


    public init(id: String, matrix: [[Int]], column: Int, row: Int) {
        self.id = id
        self.matrix = matrix
        self.column = column
        self.row = row
    }


    func setRelativeCollision() {

        let sortedPoints = points.sorted()
        var matrixPoints = [Point]()

        for (rowIndex, row) in matrix.enumerated() {
            for (columnIndex, e) in row.enumerated() {
                if e != 0 {
                    matrixPoints.append(Point(column: columnIndex, row: rowIndex))
                }
            }
        }

        sortedPoints.enumerated().forEach { i, e in
            if e == lastCollidedPoint {
                lastRelativeCollisionPoint = matrixPoints[i]
                return
            }
        }
    }
}


public struct Point: Hashable, Comparable {
    let column: Int
    let row: Int


    public static func < (lhs: Point, rhs: Point) -> Bool {
//        if lhs.column == rhs.column {
//            return lhs.row < rhs.row
//        } else {
//            return lhs.column < rhs.column
//        }

        if lhs.row == rhs.row {
            return lhs.column < rhs.column
        } else {
            return lhs.row < rhs.row
        }
    }
}
