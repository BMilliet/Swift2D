import Foundation

public enum CollisionTypes {
    case anotherShape, leftWall, rightWall, floor, ceiling, none
}

final class CollisionHandler {

    private var validCollisions = [CollisionTypes: Bool]()

    init() {}

    func setCollisions(_ collisions: [CollisionTypes]) {
        validCollisions = [CollisionTypes: Bool]()

        collisions.forEach {
            validCollisions[$0] = true
        }
    }

    func collide(_ canvas: [[Int]], _ matrix: [[Int]], _ column: Int, _ row: Int) -> CollisionTypes {
        let maxWidth = canvas.first!.count - 1
        let maxHeight = canvas.count

        for (rowIndex, _row) in matrix.enumerated() {
            for (columnIndex, _column) in _row.enumerated() {

                let newX = columnIndex + column
                let newY = rowIndex + row

                if newY > 0 && newY <= maxHeight - 1 && newX > -1 && newX <= maxWidth {
                    let currentPoint = canvas[newY][newX]

                    if currentPoint != 0 && _column != 0 && validCollisions[.anotherShape] == true {
                        return .anotherShape
                    }
                }

                if newX < 0 && _column != 0 && validCollisions[.leftWall] == true {
                    return .leftWall
                }

                if newX > maxWidth && _column != 0 && validCollisions[.rightWall] == true {
                    return .rightWall
                }

                if newY >= maxHeight && _column != 0 && validCollisions[.floor] == true {
                    return .floor
                }

                if newY < 0 && _column != 0 && validCollisions[.ceiling] == true {
                    return .ceiling
                }
            }
        }

        return .none
    }
}
