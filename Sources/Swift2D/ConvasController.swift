public enum Move {
    case left, right, up, down
}

public final class CanvasController {
    let canvasHandler = CanvasHandler()
    let collisionHandler = CollisionHandler()

    private var shapes = [String: Shape]()

    init(columns: Int, rows: Int, collisions: [CollisionTypes] = [.anotherShape, .leftWall, .rightWall, .floor, .ceiling]) {
        canvasHandler.createCanvas(columns: columns, rows: rows)
        collisionHandler.setCollisions(collisions)
    }

    var canvas: [[Int]] {
        canvasHandler.canvas
    }

    func render() {
        printAsTable(canvasHandler.canvas)
    }


    func move(_ move: Move, id: String) throws {
        guard var shape = shapes[id] else {
            throw Swift2DError.invalid(description: "could not find shape with id \(id)")
        }

        canvasHandler.remove(shape.matrix, column: shape.column, row: shape.row)

        var newColumn = shape.column
        var newRow = shape.row

        switch move {
        case .left:
            newColumn -= 1
        case .right:
            newColumn += 1
        case .up:
            newRow -= 1
        case .down:
            newRow += 1
        }

        let collision = collisionHandler.collide(canvasHandler.canvas, shape.matrix, newColumn, newRow)

        if  collision != .none {
            print("colision = \(collision)")
            canvasHandler.merge(shape.matrix, column: shape.column, row: shape.row)
            printAsTable(canvasHandler.canvas)
            return
        }

        shape.column = newColumn
        shape.row = newRow

        save(shape: shape)
        canvasHandler.merge(shape.matrix, column: shape.column, row: shape.row)
        printAsTable(canvasHandler.canvas)
    }

    func addToCanvas(shape: Shape) throws {
        if let _ = shapes[shape.id] {
            throw Swift2DError.invalid(description: "shape already in canvas \(shape.id)")
        }

        let collision = collisionHandler.collide(canvasHandler.canvas, shape.matrix, shape.column, shape.row)

        if collision != .none {
            throw Swift2DError.collision(description: "invalid positions, cant add shape \(shape.id), collision \(collision)")
        }

        save(shape: shape)
        canvasHandler.merge(shape.matrix, column: shape.column, row: shape.row)
    }

    private func save(shape: Shape) {
        shapes[shape.id] = shape
    }
}
