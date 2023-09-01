
enum CollisionTypes {
    case anotherShape, leftWall, rightWall, floor, none
}

public final class MatrixHandler {

    var matrix = [[Int]]()
    let columns: Int
    let rows: Int

    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows

        recreateMatrix()
    }

    func merge(_ subMatrix: [[Int]], column: Int, row: Int) {
        modifyMatrix(subMatrix, column, row, true)
    }

    func remove(_ subMatrix: [[Int]], column: Int, row: Int) {
        modifyMatrix(subMatrix, column, row, false)
    }

    private func recreateMatrix() {
        matrix = createEmptyMatrix(columns, rows)
    }

    private func modifyMatrix(_ subMatrix: [[Int]], _ column: Int, _ row: Int, _ add: Bool) {
        var newMatrix = matrix

        for (rowIndex, _row) in subMatrix.enumerated() {
            for (columnIndex, _column) in _row.enumerated() {
                if _column != 0 {

                    let newX = columnIndex + column
                    let newY = rowIndex + row

                    if newX >= 0 && newY >= 0 && newX <= matrix.first!.count - 1 && newY <= matrix.count - 1 {

                        newMatrix[newY][newX] = add ? _column : 0
                    }
                }
            }
        }

        matrix = newMatrix
    }

}
