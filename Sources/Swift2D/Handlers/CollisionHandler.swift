import Foundation

final class CollisionHandler {


    init() {}


    func collide(_ canvas: [[Int]], _ shape: Swift2DShape, _ column: Int, _ row: Int) -> CollisionData {
        let maxWidth = canvas.first!.count - 1
        let maxHeight = canvas.count
        let shapeMatrix = shape.matrix
        let validCollisions = shape.getValidCollisions()

        for (rowIndex, _row) in shapeMatrix.enumerated() {
            for (columnIndex, _column) in _row.enumerated() {

                let newColumn = columnIndex + column
                let newRow = rowIndex + row

                if newRow > 0 && newRow <= maxHeight - 1 && newColumn > -1 && newColumn <= maxWidth {
                    let currentPoint = canvas[newRow][newColumn]

                    if currentPoint != 0 && _column != 0 && validCollisions[.anotherShape] == true {
                        return CollisionData(type: .anotherShape, point: Point(column: newColumn, row: newRow))
                    }
                }

                if newColumn < 0 && _column != 0 && validCollisions[.leftWall] == true {
                    return CollisionData(type: .leftWall, point: Point(column: newColumn, row: newRow))
                }

                if newColumn > maxWidth && _column != 0 && validCollisions[.rightWall] == true {
                    return CollisionData(type: .rightWall, point: Point(column: newColumn, row: newRow))
                }

                if newRow >= maxHeight && _column != 0 && validCollisions[.floor] == true {
                    return CollisionData(type: .floor, point: Point(column: newColumn, row: newRow))
                }

                if newRow < 0 && _column != 0 && validCollisions[.ceiling] == true {
                    return CollisionData(type: .ceiling, point: Point(column: newColumn, row: newRow))
                }
            }
        }
        return CollisionData(type: .none, point: Point(column: column, row: row))
    }
}
