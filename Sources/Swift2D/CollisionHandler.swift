import Foundation

struct CollisionHandler {

    static func collide(_ mainMatrix: [[Int]], _ subMatrix: [[Int]], _ column: Int, _ row: Int) -> CollisionTypes {
        let maxWidth = mainMatrix.first!.count
        let maxHeight = mainMatrix.count

        for (rowIndex, _row) in subMatrix.enumerated() {
            for (columnIndex, _column) in _row.enumerated() {

                let newX = columnIndex + column
                let newY = rowIndex + row

                // collide with another shape
                if newY > 0 && newY <= maxHeight - 1 && newX > -1 && newX <= maxWidth {
                    let currentPoint = mainMatrix[newY][newX]

                    if currentPoint != 0 && _column != 0 {
                        return .anotherShape
                    }
                }

                // collide left wall
                if newX < 0 && _column != 0 {
                    return .leftWall
                }

                // collide right wall
                if newX >= maxWidth && _column != 0 {
                    return .rightWall
                }

                // collide floor
                if newY >= maxHeight && _column != 0 {
                    return .floor
                }

                // collide
                if newY >= maxHeight && _column != 0 {
                    return .floor
                }
            }
        }

        return .none
    }
}
