public final class CanvasHandler {

    var canvas = [[Int]]()

    init() {}


    lazy var canvasHeight: Int = {
        canvas.count - 1
    }()


    lazy var canvasWidth: Int = {
        canvas.first!.count - 1
    }()


    func merge(_ shape: Shape, column: Int, row: Int) {
        editCanvas(shape, column, row, true)
    }


    func remove(_ shape: Shape, column: Int, row: Int) {
        editCanvas(shape, column, row, false)
    }


    func createCanvas(columns: Int, rows: Int) {
        canvas = createEmptyCanvas(columns, rows)
    }

    
    private func editCanvas(_ shape: Shape, _ column: Int, _ row: Int, _ add: Bool) {
        var newCanvas = canvas
        var matrixPoints = [Point]()

        for (rowIndex, _row) in shape.matrix.enumerated() {
            for (columnIndex, _column) in _row.enumerated() {
                if _column != 0 {

                    let newColumn = columnIndex + column
                    let newRow = rowIndex + row

                    if newColumn >= 0 && newRow >= 0 && newColumn <= canvasWidth && newRow <= canvasHeight {

                        if add {
                            newCanvas[newRow][newColumn] = _column
                            matrixPoints.append(Point(column: newColumn, row: newRow))
                        } else {
                            newCanvas[newRow][newColumn] = 0
                        }
                    }
                }
            }
        }

        shape.points = matrixPoints
        canvas = newCanvas
    }

}
