public final class Swift2DShape {
    public let id: String
    public var matrix: [[Int]]
    public var column: Int
    public var row: Int
    public var points: [Point] = []


    public var lastCollision: CollisionType = .none
    public var lastCollidedShape: String = ""
    public var lastCollidedPoint: Point? = nil
    public var lastRelativeCollisionPoint: Point? = nil

    private var validCollisions = [CollisionType: Bool]()


    public init(id: String, matrix: [[Int]], column: Int, row: Int, collisions: [CollisionType] = CollisionFactory.all()) {
        self.id = id
        self.matrix = matrix
        self.column = column
        self.row = row

        collisions.forEach {
            self.validCollisions[$0] = true
        }
    }


    public func printMatrix() {
        print(stringMatrix(matrix))
    }

    public func getValidCollisions() -> [CollisionType: Bool] {
        return validCollisions
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

