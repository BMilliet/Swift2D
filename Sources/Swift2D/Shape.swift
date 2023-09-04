public final class Shape {
    public let id: String
    public var matrix: [[Int]]

    private var _column: Int
    private var _row: Int

    public init(id: String, matrix: [[Int]], column: Int, row: Int) {
        self.id = id
        self.matrix = matrix
        self._column = column
        self._row = row
    }

    var column: Int { _column }
    var row: Int { _row }

    func set(column: Int? = nil, row: Int? = nil) {
        if let column = column { _column = column }
        if let row = row { _row = row }
    }
}
