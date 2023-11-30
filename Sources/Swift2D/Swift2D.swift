public final class Swift2D {

    private let canvasHandler = CanvasHandler()
    private let collisionHandler = CollisionHandler()
    private var logger = Logger()

    private var shapes = [String: Swift2DShape]()
    private var points = [Point: String]()
    private var camera: Camera?

    public init(columns: Int, rows: Int, log: Bool = false) {
        canvasHandler.createCanvas(columns: columns, rows: rows)
        logger.quiet = !log
    }


    public var canvas: [[Int]] { canvasHandler.canvas }
    public var getShapeKeys: [String] { shapes.keys.map { $0 } }
    public var getShapes: [String: Swift2DShape] { shapes }
    public var getPoints: [Point: String] { points }
    public var getCamera: Camera? { camera }
    public func setCamera(_ _camera: Camera) { camera = _camera }


    public func shape(_ id: String) -> Swift2DShape? {
        return shapes[id]
    }


    public func printCanvas() {
        printMatrix(canvas)
    }


    public func printMatrix(_ a: [[Int]]) {
        print(stringMatrix(a))
    }


    public func moveCamera(_ move: Move) {
        camera?.move(move)
    }

    
    public func cameraFrame() -> [[Int]]? {
        guard let camera = camera else { return nil }
        return canvasHandler.getCanvasSlice(with: camera.getResolution)
    }


    public func remove(id: String) {
        guard let shape = shapes[id] else {
            logger.log("shape not found, id: \(id)")
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

        setCollision(shape: shape, collisionData: collision)

        if collision.type == .none {
            shape.column = newColumn
            shape.row = newRow

            save(shape: shape)
            merge(shape, column: shape.column, row: shape.row)
            logger.log("\(stringMatrix(canvasHandler.canvas))")
            return
        }

        merge(shape, column: shape.column, row: shape.row)
    }


    private func setCollision(shape: Swift2DShape, collisionData: CollisionData) {
        let previousCollidedShapeId = shape.lastCollidedShape

        shape.lastCollision = collisionData.type

        if let collidedShape = shapes[previousCollidedShapeId] {
            collidedShape.lastCollidedShape = ""
            collidedShape.lastCollision = .none
            collidedShape.lastCollidedPoint = nil
            collidedShape.lastRelativeCollisionPoint = nil
        }

        switch collisionData.type {
        case .anotherShape:
            guard let id = points[collisionData.point] else { return }
            guard let collidedShape = shapes[id] else { return }
            collidedShape.lastCollidedShape = shape.id
            collidedShape.lastCollision = .anotherShape
            collidedShape.lastCollidedPoint = collisionData.point
            collidedShape.setRelativeCollision()
            shape.lastCollidedPoint = collisionData.point
            shape.lastCollidedShape = id

        case .none:
            shape.lastCollidedPoint = nil
            shape.lastCollidedShape = ""
        default:
            shape.lastCollidedPoint = collisionData.point
            shape.lastCollidedShape = ""
        }
    }


    public func addToCanvas(shape: Swift2DShape) throws {
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


    func merge(_ shape: Swift2DShape, column: Int, row: Int) {
        shape.points = canvasHandler.merge(shape.matrix, column: column, row: row)
        shape.points.forEach { points[$0] = shape.id }
    }


    func remove(_ shape: Swift2DShape, column: Int, row: Int) {
        canvasHandler.remove(shape.matrix, column: column, row: row)
        shape.points = []
        shape.points.forEach { points.removeValue(forKey: $0) }
    }


    private func save(shape: Swift2DShape) {
        shapes[shape.id] = shape
    }
}
