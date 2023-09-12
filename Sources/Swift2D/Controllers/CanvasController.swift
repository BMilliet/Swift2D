public final class CanvasController {

    private let canvasHandler = CanvasHandler()
    private let collisionHandler = CollisionHandler()


    private var shapes = [String: Shape]()
    private var points = [Point: String]()


    public init(columns: Int, rows: Int, collisions: [CollisionType] = [.anotherShape, .leftWall, .rightWall, .floor, .ceiling]) {
        canvasHandler.createCanvas(columns: columns, rows: rows)
        collisionHandler.setCollisions(collisions)
    }


    public var canvas: [[Int]] { canvasHandler.canvas }
    public var getShapeKeys: [String] { shapes.keys.map { $0 } }
    public var getShapes: [String: Shape] { shapes }
    public var getPoints: [Point: String] { points }


    public func render() {
        printAsTable(canvasHandler.canvas)
    }


    public func shape(_ id: String) -> Shape? {
        return shapes[id]
    }


    public func remove(id: String) {
        guard let shape = shapes[id] else {
            print("shape not found")
            return
        }

        remove(shape, column: shape.column, row: shape.row)
        shapes.removeValue(forKey: id)
    }


    public func move(_ move: Move, id: String) throws {
        guard let shape = shapes[id] else {
            throw Swift2DError.invalid(description: "could not find shape with id \(id)")
        }

        remove(shape, column: shape.column, row: shape.row)

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

        let collision = collisionHandler.collide(canvasHandler.canvas, shape, newColumn, newRow)

        if collision.type == .none {
            shape.column = newColumn
            shape.row = newRow

            save(shape: shape)
            merge(shape, column: shape.column, row: shape.row)
            printAsTable(canvasHandler.canvas)
            return
        }


        print("colision = \(collision)")
        print("colision point = \(collision.point)")
        canvasHandler.merge(shape, column: shape.column, row: shape.row)
        printAsTable(canvasHandler.canvas)


        if collision.type == .anotherShape {
            guard let id = points[collision.point] else { return }
            guard let collidedShape = shapes[id] else { return }
            collidedShape.collisions = [.anotherShape]
        }
    }

    
    public func addToCanvas(shape: Shape) throws {
        if let _ = shapes[shape.id] {
            throw Swift2DError.invalid(description: "shape already in canvas \(shape.id)")
        }

        let collision = collisionHandler.collide(canvasHandler.canvas, shape, shape.column, shape.row)

        if collision.type != .none {
            throw Swift2DError.collision(description: "invalid positions, cant add shape \(shape.id), collision \(collision)")
        }

        save(shape: shape)
        merge(shape, column: shape.column, row: shape.row)
    }


    func merge(_ shape: Shape, column: Int, row: Int) {
        canvasHandler.merge(shape, column: column, row: row)
        shape.points.forEach { points[$0] = shape.id }
    }


    func remove(_ shape: Shape, column: Int, row: Int) {
        canvasHandler.remove(shape, column: column, row: row)
        shape.points.forEach { points.removeValue(forKey: $0) }
    }


    private func save(shape: Shape) {
        shapes[shape.id] = shape
    }
}
