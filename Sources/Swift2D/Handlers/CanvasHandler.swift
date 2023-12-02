public final class CanvasHandler {

    var canvas = [[Int]]()

    init() {}


    lazy var canvasHeight: Int = {
        canvas.count - 1
    }()


    lazy var canvasWidth: Int = {
        canvas.first!.count - 1
    }()


    func merge(_ matrix: [[Int]], column: Int, row: Int) -> [Point] {
        return editCanvas(matrix, column, row, true)
    }


    func remove(_ matrix: [[Int]], column: Int, row: Int) {
        editCanvas(matrix, column, row, false)
    }


    func createCanvas(columns: Int, rows: Int) {
        canvas = createEmptyCanvas(columns, rows)
    }


    func getCanvasSlice(with resolution: Resolution) -> [[Int]]? {
        let minRow = resolution.topLeft.row
        let maxRow = resolution.bottomRight.row
        let minCol = resolution.topLeft.column
        let maxCol = resolution.bottomRight.column

        var subCanvas = [[Int]]()
        var cut = [[Int]]()

        if minCol < 0 || maxCol >= canvas[0].count {
            return nil
        }

        for (i, r) in canvas.enumerated() {
            if i < minRow || i > maxRow { continue }
            subCanvas.append(r)
        }

        for (i, _) in subCanvas.enumerated() {
            let n = Array(subCanvas[i][minCol...maxCol])
            cut.append(n)
        }

        return cut
    }


    @discardableResult
    private func editCanvas(_ matrix: [[Int]], _ column: Int, _ row: Int, _ add: Bool) -> [Point] {
        var newCanvas = canvas
        var occupiedPoints = [Point]()

        for (rowIndex, _row) in matrix.enumerated() {
            for (columnIndex, _column) in _row.enumerated() {
                if _column != 0 {

                    let newColumn = columnIndex + column
                    let newRow = rowIndex + row

                    if newColumn >= 0 && newRow >= 0 && newColumn <= canvasWidth && newRow <= canvasHeight {

                        if add {
                            newCanvas[newRow][newColumn] = _column
                            occupiedPoints.append(Point(column: newColumn, row: newRow))
                        } else {
                            newCanvas[newRow][newColumn] = 0
                        }
                    }
                }
            }
        }

        canvas = newCanvas
        return occupiedPoints
    }
}
