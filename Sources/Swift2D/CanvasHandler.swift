
public final class CanvasHandler {

    var canvas = [[Int]]()

    init() {}

    lazy var canvasHeight: Int = {
        canvas.count - 1
    }()

    lazy var canvasWidth: Int = {
        canvas.first!.count - 1
    }()


    func merge(_ subMatrix: [[Int]], column: Int, row: Int) {
        addToCanvas(subMatrix, column, row, true)
    }

    func remove(_ subMatrix: [[Int]], column: Int, row: Int) {
        addToCanvas(subMatrix, column, row, false)
    }

    func createCanvas(columns: Int, rows: Int) {
        canvas = createEmptyCanvas(columns, rows)
    }

    private func addToCanvas(_ matrix: [[Int]], _ column: Int, _ row: Int, _ add: Bool) {
        var newCanvas = canvas

        for (rowIndex, _row) in matrix.enumerated() {
            for (columnIndex, _column) in _row.enumerated() {
                if _column != 0 {

                    let newX = columnIndex + column
                    let newY = rowIndex + row

                    if newX >= 0 && newY >= 0 && newX <= canvasWidth && newY <= canvasHeight {

                        newCanvas[newY][newX] = add ? _column : 0
                    }
                }
            }
        }

        canvas = newCanvas
    }

}
