public final class Shape {
    public let id: String
    public var matrix: [[Int]]
    public var column: Int
    public var row: Int

    public init(id: String, matrix: [[Int]], column: Int, row: Int) {
        self.id = id
        self.matrix = matrix
        self.column = column
        self.row = row
    }
}
