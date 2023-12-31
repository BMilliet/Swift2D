import XCTest
@testable import Swift2D

final class Swift2DTests: XCTestCase {

    func test_basic_movement_in_canvas() throws {

        let swift2d = Swift2D(columns: 6, rows: 6)

        let matrix = [
            [1,1],
            [1,1],
        ]

        let shape = Swift2DShape(id: "m", matrix: matrix, column: 2, row: 2)

        try swift2d.addToCanvas(shape: shape)

        XCTAssertEqual("m", swift2d.getShapeKeys.first!)

        var expected = [
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,1,1,0,0],
            [0,0,1,1,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
        ]

        XCTAssertEqual(expected, swift2d.canvas)

        expected = [
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,1,1,0,0,0],
            [0,1,1,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
        ]
        swift2d.move(.left, id: "m")
        XCTAssertEqual(expected, swift2d.canvas)

        expected = [
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,1,1,0,0],
            [0,0,1,1,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
        ]
        swift2d.move(.right, id: "m")
        XCTAssertEqual(expected, swift2d.canvas)

        expected = [
            [0,0,0,0,0,0],
            [0,0,1,1,0,0],
            [0,0,1,1,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
        ]
        swift2d.move(.up, id: "m")
        XCTAssertEqual(expected, swift2d.canvas)

        expected = [
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,1,1,0,0],
            [0,0,1,1,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
        ]
        swift2d.move(.down, id: "m")
        XCTAssertEqual(expected, swift2d.canvas)

        expected = [
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
        ]
        swift2d.remove(id: "m")
        XCTAssertEqual(expected, swift2d.canvas)
        XCTAssertEqual([], swift2d.getShapeKeys)
    }

    func test_collision_in_canvas() throws {

        let swift2d = Swift2D(columns: 2, rows: 2)

        let matrix = [
            [1],
        ]

        let shape = Swift2DShape(id: "m", matrix: matrix, column: 0, row: 0)

        try swift2d.addToCanvas(shape: shape)

        var expected = [
            [1,0],
            [0,0]
        ]

        XCTAssertEqual(expected, swift2d.canvas)

        swift2d.move(.left, id: "m")
        XCTAssertEqual(expected, swift2d.canvas)

        swift2d.move(.up, id: "m")
        XCTAssertEqual(expected, swift2d.canvas)


        expected = [
            [0,0],
            [1,0]
        ]
        swift2d.move(.down, id: "m")
        XCTAssertEqual(expected, swift2d.canvas)
        swift2d.move(.down, id: "m")
        XCTAssertEqual(expected, swift2d.canvas)


        expected = [
            [0,0],
            [0,1]
        ]
        swift2d.move(.right, id: "m")
        XCTAssertEqual(expected, swift2d.canvas)
        swift2d.move(.right, id: "m")
        XCTAssertEqual(expected, swift2d.canvas)
    }

    func test_disabled_collision_in_canvas() throws {

        let swift2d = Swift2D(columns: 3, rows: 3)

        let matrix = [
            [1,1],
            [1,1],
        ]

        let shape = Swift2DShape(id: "m", matrix: matrix, column: 0, row: 0, collisions: [])

        try swift2d.addToCanvas(shape: shape)

        var expected = [
            [1,1,0],
            [1,1,0],
            [0,0,0],
        ]
        XCTAssertEqual(expected, swift2d.canvas)

        expected = [
            [1,0,0],
            [1,0,0],
            [0,0,0],
        ]
        swift2d.move(.left, id: "m")
        XCTAssertEqual(expected, swift2d.canvas)

        expected = [
            [0,0,0],
            [0,0,0],
            [0,0,0],
        ]
        swift2d.move(.left, id: "m")
        XCTAssertEqual(expected, swift2d.canvas)

        expected = [
            [1,1,0],
            [1,1,0],
            [0,0,0],
        ]
        swift2d.move(.right, id: "m")
        swift2d.move(.right, id: "m")
        XCTAssertEqual(expected, swift2d.canvas)

        expected = [
            [1,1,0],
            [0,0,0],
            [0,0,0],
        ]
        swift2d.move(.up, id: "m")
        XCTAssertEqual(expected, swift2d.canvas)

        expected = [
            [0,0,0],
            [0,0,0],
            [0,0,0],
        ]
        swift2d.move(.up, id: "m")
        XCTAssertEqual(expected, swift2d.canvas)

        expected = [
            [0,0,0],
            [0,0,0],
            [1,1,0],
        ]
        swift2d.move(.down, id: "m")
        swift2d.move(.down, id: "m")
        swift2d.move(.down, id: "m")
        swift2d.move(.down, id: "m")
        XCTAssertEqual(expected, swift2d.canvas)

        expected = [
            [0,0,0],
            [0,0,0],
            [0,0,1],
        ]
        swift2d.move(.right, id: "m")
        swift2d.move(.right, id: "m")
        XCTAssertEqual(expected, swift2d.canvas)
    }

    func test_collision_with_matrix() throws {

        let swift2d = Swift2D(columns: 6, rows: 6)

        let matrix1 = [
            [1,1,1],
            [0,1,0]
        ]

        let matrix2 = [
            [0,1],
            [0,1],
            [1,1]
        ]

        let shapeM = Swift2DShape(id: "m", matrix: matrix1, column: 2, row: 0)
        let shapeN = Swift2DShape(id: "n", matrix: matrix2, column: 3, row: 3)

        try swift2d.addToCanvas(shape: shapeM)
        try swift2d.addToCanvas(shape: shapeN)

        var expected = [
            [0,0,1,1,1,0],
            [0,0,0,1,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,1,0],
            [0,0,0,0,1,0],
            [0,0,0,1,1,0],
        ]
        XCTAssertEqual(expected, swift2d.canvas)
        XCTAssertEqual(.none, shapeM.lastCollision)
        XCTAssertEqual(.none, shapeN.lastCollision)


        expected = [
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,1,1,1,0],
            [0,0,0,1,1,0],
            [0,0,0,0,1,0],
            [0,0,0,1,1,0],
        ]
        swift2d.move(.down, id: "m")
        XCTAssertEqual(.none, shapeM.lastCollision)
        XCTAssertEqual(.none, shapeN.lastCollision)
        XCTAssertTrue(shapeM.lastCollidedShape.isEmpty)
        XCTAssertTrue(shapeN.lastCollidedShape.isEmpty)
        XCTAssertNil(shapeM.lastCollidedPoint)
        XCTAssertNil(shapeN.lastCollidedPoint)

        swift2d.move(.down, id: "m")
        XCTAssertEqual(.none, shapeM.lastCollision)
        XCTAssertEqual(.none, shapeN.lastCollision)
        XCTAssertTrue(shapeM.lastCollidedShape.isEmpty)
        XCTAssertTrue(shapeN.lastCollidedShape.isEmpty)

        swift2d.move(.down, id: "m")
        XCTAssertEqual(.anotherShape, shapeM.lastCollision)
        XCTAssertEqual(.anotherShape, shapeN.lastCollision)
        XCTAssertEqual("n", shapeM.lastCollidedShape)
        XCTAssertEqual("m", shapeN.lastCollidedShape)
        XCTAssertEqual(Point(column: 4, row: 3), shapeM.lastCollidedPoint)
        XCTAssertEqual(Point(column: 4, row: 3), shapeN.lastCollidedPoint)
        XCTAssertEqual(Point(column: 1, row: 0), shapeN.lastRelativeCollisionPoint)
        XCTAssertEqual(expected, swift2d.canvas)

        swift2d.move(.right, id: "m")
        XCTAssertEqual(expected, swift2d.canvas)

        expected = [
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [1,1,1,0,1,0],
            [0,1,0,0,1,0],
            [0,0,0,1,1,0],
        ]
        swift2d.move(.left, id: "m")
        swift2d.move(.left, id: "m")
        swift2d.move(.down, id: "m")

        XCTAssertEqual(.none, shapeM.lastCollision)
        XCTAssertEqual(.none, shapeN.lastCollision)
        XCTAssertEqual("", shapeM.lastCollidedShape)
        XCTAssertEqual("", shapeN.lastCollidedShape)
        XCTAssertNil(shapeM.lastCollidedPoint)
        XCTAssertNil(shapeN.lastCollidedPoint)
        XCTAssertNil(shapeN.lastRelativeCollisionPoint)

        XCTAssertEqual(expected, swift2d.canvas)

        swift2d.move(.left, id: "m")

        XCTAssertEqual(.leftWall, shapeM.lastCollision)
        XCTAssertEqual(.none, shapeN.lastCollision)
        XCTAssertEqual("", shapeM.lastCollidedShape)
        XCTAssertEqual("", shapeN.lastCollidedShape)
        XCTAssertEqual(Point(column: -1, row: 3), shapeM.lastCollidedPoint)
        XCTAssertNil(shapeN.lastCollidedPoint)

        XCTAssertEqual(expected, swift2d.canvas)

        expected = [
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,1,1,1,1,0],
            [0,0,1,0,1,0],
            [0,0,0,1,1,0],
        ]
        swift2d.move(.right, id: "m")
        swift2d.move(.right, id: "m")

        XCTAssertEqual(.anotherShape, shapeM.lastCollision)
        XCTAssertEqual(.anotherShape, shapeN.lastCollision)
        XCTAssertEqual("n", shapeM.lastCollidedShape)
        XCTAssertEqual("m", shapeN.lastCollidedShape)
        XCTAssertEqual(Point(column: 4, row: 3), shapeN.lastCollidedPoint)
        XCTAssertEqual(Point(column: 4, row: 3), shapeM.lastCollidedPoint)
        XCTAssertEqual(Point(column: 1, row: 0), shapeN.lastRelativeCollisionPoint)

        XCTAssertEqual(expected, swift2d.canvas)

        expected = [
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,1,0],
            [0,1,1,1,1,0],
            [0,0,1,1,1,0],
        ]
        swift2d.move(.down, id: "m")
        swift2d.move(.down, id: "m")

        XCTAssertEqual(.anotherShape, shapeM.lastCollision)
        XCTAssertEqual(.anotherShape, shapeN.lastCollision)
        XCTAssertEqual("n", shapeM.lastCollidedShape)
        XCTAssertEqual("m", shapeN.lastCollidedShape)
        XCTAssertEqual(Point(column: 3, row: 5), shapeN.lastCollidedPoint)
        XCTAssertEqual(Point(column: 3, row: 5), shapeM.lastCollidedPoint)
        XCTAssertEqual(Point(column: 0, row: 2), shapeN.lastRelativeCollisionPoint)

        XCTAssertEqual(expected, swift2d.canvas)
    }

    func test_relative_collision_point() throws {
        let swift2d = Swift2D(columns: 10, rows: 10)

        let matrix1 = [
            [1,1,1,1,1,1],
            [1,1,1,1,1,1],
            [1,1,0,0,1,1],
        ]

        let matrix2 = [
            [2],
        ]

        let shapeA = Swift2DShape(id: "a", matrix: matrix1, column: 2, row: 2)
        let particle1 = Swift2DShape(id: "p1", matrix: matrix2, column: 0, row: 2)

        try swift2d.addToCanvas(shape: shapeA)
        try swift2d.addToCanvas(shape: particle1)

        var expected = [
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [2,0,1,1,1,1,1,1,0,0],
            [0,0,1,1,1,1,1,1,0,0],
            [0,0,1,1,0,0,1,1,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
        ]
        XCTAssertEqual(expected, swift2d.canvas)
        XCTAssertEqual(.none, shapeA.lastCollision)
        XCTAssertEqual("", shapeA.lastCollidedShape)
        XCTAssertNil(shapeA.lastRelativeCollisionPoint)


        swift2d.move(.right, id: "p1")
        swift2d.move(.right, id: "p1")

        expected = [
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,2,1,1,1,1,1,1,0,0],
            [0,0,1,1,1,1,1,1,0,0],
            [0,0,1,1,0,0,1,1,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
        ]
        XCTAssertEqual(expected, swift2d.canvas)
        XCTAssertEqual(.anotherShape, shapeA.lastCollision)
        XCTAssertEqual("p1", shapeA.lastCollidedShape)
        XCTAssertEqual(Point(column: 0, row: 0), shapeA.lastRelativeCollisionPoint)


        swift2d.move(.down, id: "p1")
        swift2d.move(.right, id: "p1")

        expected = [
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,1,1,1,1,1,1,0,0],
            [0,2,1,1,1,1,1,1,0,0],
            [0,0,1,1,0,0,1,1,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
        ]
        XCTAssertEqual(expected, swift2d.canvas)
        XCTAssertEqual(.anotherShape, shapeA.lastCollision)
        XCTAssertEqual("p1", shapeA.lastCollidedShape)
        XCTAssertEqual(Point(column: 0, row: 1), shapeA.lastRelativeCollisionPoint)


        swift2d.move(.down, id: "p1")
        swift2d.move(.right, id: "p1")

        expected = [
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,1,1,1,1,1,1,0,0],
            [0,0,1,1,1,1,1,1,0,0],
            [0,2,1,1,0,0,1,1,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
        ]
        XCTAssertEqual(expected, swift2d.canvas)
        XCTAssertEqual(.anotherShape, shapeA.lastCollision)
        XCTAssertEqual("p1", shapeA.lastCollidedShape)
        XCTAssertEqual(Point(column: 0, row: 2), shapeA.lastRelativeCollisionPoint)


        swift2d.move(.down, id: "p1")
        swift2d.move(.right, id: "p1")
        swift2d.move(.right, id: "p1")
        swift2d.move(.up, id: "p1")

        expected = [
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,1,1,1,1,1,1,0,0],
            [0,0,1,1,1,1,1,1,0,0],
            [0,0,1,1,0,0,1,1,0,0],
            [0,0,0,2,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
        ]
        XCTAssertEqual(expected, swift2d.canvas)
        XCTAssertEqual(.anotherShape, shapeA.lastCollision)
        XCTAssertEqual("p1", shapeA.lastCollidedShape)
        XCTAssertEqual(Point(column: 1, row: 2), shapeA.lastRelativeCollisionPoint)


        swift2d.move(.right, id: "p1")
        swift2d.move(.up, id: "p1")
        swift2d.move(.up, id: "p1")

        expected = [
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,1,1,1,1,1,1,0,0],
            [0,0,1,1,1,1,1,1,0,0],
            [0,0,1,1,2,0,1,1,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
        ]
        XCTAssertEqual(expected, swift2d.canvas)
        XCTAssertEqual(.anotherShape, shapeA.lastCollision)
        XCTAssertEqual("p1", shapeA.lastCollidedShape)
        XCTAssertEqual(Point(column: 2, row: 1), shapeA.lastRelativeCollisionPoint)


        swift2d.move(.down, id: "p1")
        swift2d.move(.right, id: "p1")
        swift2d.move(.right, id: "p1")
        swift2d.move(.right, id: "p1")
        swift2d.move(.up, id: "p1")

        expected = [
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,1,1,1,1,1,1,0,0],
            [0,0,1,1,1,1,1,1,0,0],
            [0,0,1,1,0,0,1,1,0,0],
            [0,0,0,0,0,0,0,2,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
        ]
        XCTAssertEqual(expected, swift2d.canvas)
        XCTAssertEqual(.anotherShape, shapeA.lastCollision)
        XCTAssertEqual("p1", shapeA.lastCollidedShape)
        XCTAssertEqual(Point(column: 5, row: 2), shapeA.lastRelativeCollisionPoint)


        swift2d.move(.right, id: "p1")
        swift2d.move(.up, id: "p1")
        swift2d.move(.up, id: "p1")
        swift2d.move(.up, id: "p1")
        swift2d.move(.left, id: "p1")

        expected = [
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,1,1,1,1,1,1,2,0],
            [0,0,1,1,1,1,1,1,0,0],
            [0,0,1,1,0,0,1,1,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
        ]
        XCTAssertEqual(expected, swift2d.canvas)
        XCTAssertEqual(.anotherShape, shapeA.lastCollision)
        XCTAssertEqual("p1", shapeA.lastCollidedShape)
        XCTAssertEqual(Point(column: 5, row: 0), shapeA.lastRelativeCollisionPoint)
    }


    func test_camera() throws {

        let swift2d = Swift2D(columns: 6, rows: 6)

        let matrix1 = [
            [1,1,1],
            [0,1,0]
        ]

        let matrix2 = [
            [0,1],
            [0,1],
            [1,1]
        ]

        let matrix3 = [
            [1],
            [1]
        ]

        let shapeM = Swift2DShape(id: "m", matrix: matrix1, column: 2, row: 0)
        let shapeN = Swift2DShape(id: "n", matrix: matrix2, column: 3, row: 3)
        let shapeO = Swift2DShape(id: "o", matrix: matrix3, column: 0, row: 4)

        try swift2d.addToCanvas(shape: shapeM)
        try swift2d.addToCanvas(shape: shapeN)
        try swift2d.addToCanvas(shape: shapeO)

        var expected = [
            [0,0,1,1,1,0],
            [0,0,0,1,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,1,0],
            [1,0,0,0,1,0],
            [1,0,0,1,1,0],
        ]

        XCTAssertEqual(expected, swift2d.canvas)

        swift2d.createCamera(topLeft: .init(column: 1, row: 1), bottomRight: .init(column: 3, row: 2))

        expected = [
            [0,0,1],
            [0,0,0],
        ]

        XCTAssertEqual(expected, swift2d.cameraFrame())

        swift2d.createCamera(topLeft: .init(column: 1, row: 1), bottomRight: .init(column: 4, row: 5))

        expected = [
            [0,0,1,0],
            [0,0,0,0],
            [0,0,0,1],
            [0,0,0,1],
            [0,0,1,1],
        ]

        XCTAssertEqual(expected, swift2d.cameraFrame())

        swift2d.createCamera(topLeft: .init(column: 2, row: 2), bottomRight: .init(column: 4, row: 4))

        expected = [
            [0,0,0],
            [0,0,1],
            [0,0,1],
        ]

        XCTAssertEqual(expected, swift2d.cameraFrame())

        swift2d.moveCamera(.down)

        expected = [
            [0,0,1],
            [0,0,1],
            [0,1,1],
        ]

        XCTAssertEqual(expected, swift2d.cameraFrame())

        swift2d.moveCamera(.right)

        expected = [
            [0,1,0],
            [0,1,0],
            [1,1,0],
        ]

        XCTAssertEqual(expected, swift2d.cameraFrame())

        // +1 offset right
        swift2d.moveCamera(.right)

        expected = [
            [0,1,0],
            [0,1,0],
            [1,1,0],
        ]

        XCTAssertEqual(expected, swift2d.cameraFrame())

        // +2 offset right
        swift2d.moveCamera(.right)

        expected = [
            [0,1,0],
            [0,1,0],
            [1,1,0],
        ]

        XCTAssertEqual(expected, swift2d.cameraFrame())

        // 1 off-camera
        swift2d.moveCamera(.left)
        XCTAssertEqual(expected, swift2d.cameraFrame())

        // 0 off-camera
        swift2d.moveCamera(.left)
        XCTAssertEqual(expected, swift2d.cameraFrame())

        expected = [
            [0,0,1],
            [0,0,1],
            [0,1,1],
        ]

        swift2d.moveCamera(.left)
        XCTAssertEqual(expected, swift2d.cameraFrame())

        expected = [
            [0,0,0],
            [0,0,0],
            [0,0,1],
        ]

        swift2d.moveCamera(.left)
        XCTAssertEqual(expected, swift2d.cameraFrame())

        expected = [
            [0,0,0],
            [1,0,0],
            [1,0,0],
        ]

        // touch wall
        swift2d.moveCamera(.left)
        XCTAssertEqual(expected, swift2d.cameraFrame())

        // +1 offset
        swift2d.moveCamera(.left)
        XCTAssertEqual(expected, swift2d.cameraFrame())

        // +2 offset
        swift2d.moveCamera(.left)
        XCTAssertEqual(expected, swift2d.cameraFrame())

        // 1 offset
        swift2d.moveCamera(.right)
        XCTAssertEqual(expected, swift2d.cameraFrame())

        // 0 offset
        swift2d.moveCamera(.right)
        XCTAssertEqual(expected, swift2d.cameraFrame())

        expected = [
            [0,0,1],
            [0,0,0],
            [0,0,0],
        ]

        swift2d.moveCamera(.up)
        swift2d.moveCamera(.up)

        // hit wall
        swift2d.moveCamera(.up)
        XCTAssertEqual(expected, swift2d.cameraFrame())

        // offset +1
        swift2d.moveCamera(.up)
        XCTAssertEqual(expected, swift2d.cameraFrame())

        // offset +2
        swift2d.moveCamera(.up)
        XCTAssertEqual(expected, swift2d.cameraFrame())

        // offset row = 2

        swift2d.moveCamera(.down)
        swift2d.moveCamera(.down)
        // offset row = 0
        XCTAssertEqual(expected, swift2d.cameraFrame())

        expected = [
            [0,1,1],
            [0,0,1],
            [0,0,0],
        ]

        swift2d.moveCamera(.right)
        XCTAssertEqual(expected, swift2d.cameraFrame())

        expected = [
            [0,0,1],
            [0,0,0],
            [0,0,0],
        ]

        swift2d.moveCamera(.down)
        XCTAssertEqual(expected, swift2d.cameraFrame())
    }


    func test_move_with_camera() throws {

        let swift2d = Swift2D(columns: 7, rows: 7)

        let matrix1 = [
            [1],
            [1]
        ]


        let matrix2 = [
            [0,1,0],
            [1,1,1]
        ]

        let shapeM = Swift2DShape(id: "m", matrix: matrix1, column: 3, row: 2)
        let shapeN = Swift2DShape(id: "n", matrix: matrix2, column: 0, row: 4)

        try swift2d.addToCanvas(shape: shapeM)
        try swift2d.addToCanvas(shape: shapeN)

        var expected = [
            [0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0],
            [0,0,0,1,0,0,0],
            [0,0,0,1,0,0,0],
            [0,1,0,0,0,0,0],
            [1,1,1,0,0,0,0],
            [0,0,0,0,0,0,0],
        ]

        XCTAssertEqual(expected, swift2d.canvas)

        swift2d.createCamera(topLeft: .init(column: 1, row: 1), bottomRight: .init(column: 5, row: 4))

        expected = [
            [0,0,0,0,0],
            [0,0,1,0,0],
            [0,0,1,0,0],
            [1,0,0,0,0],
        ]

        XCTAssertEqual(expected, swift2d.cameraFrame())
        
        expected = [
            [0,0,0,0,0],
            [0,0,1,0,0],
            [1,0,1,0,0],
            [1,1,0,0,0],
        ]

        swift2d.move(.down, id: "m", withCamera: true)
        XCTAssertEqual(expected, swift2d.cameraFrame())

        // collide with another shape
        expected = [
            [0,0,0,0,0],
            [0,0,1,0,0],
            [0,1,1,0,0],
            [1,1,1,0,0],
        ]

        // collide multiple times (sides) to ensure camera position
        swift2d.move(.left, id: "m", withCamera: true)
        swift2d.move(.left, id: "m", withCamera: true)
        swift2d.move(.left, id: "m", withCamera: true)
        swift2d.move(.down, id: "m", withCamera: true)
        swift2d.move(.down, id: "m", withCamera: true)
        XCTAssertEqual(expected, swift2d.cameraFrame())


        // release from collision
        expected = [
            [0,0,0,0,0],
            [0,0,1,0,0],
            [1,0,1,0,0],
            [1,1,0,0,0],
        ]

        swift2d.move(.right, id: "m", withCamera: true)
        XCTAssertEqual(expected, swift2d.cameraFrame())

        expected = [
            [0,0,0,0,0],
            [0,0,1,0,0],
            [0,0,1,0,0],
            [1,0,0,0,0],
        ]

        swift2d.move(.up, id: "m", withCamera: true)
        XCTAssertEqual(expected, swift2d.cameraFrame())


        // move near wall, camera stick to bounds
        expected = [
            [0,0,0,0,0],
            [0,1,0,0,0],
            [0,1,0,0,0],
            [0,1,0,0,0],
        ]


        swift2d.move(.left, id: "m", withCamera: true)
        swift2d.move(.left, id: "m", withCamera: true)
        XCTAssertEqual(expected, swift2d.cameraFrame())

        // hit wall left
        expected = [
            [0,0,0,0,0],
            [1,0,0,0,0],
            [1,0,0,0,0],
            [0,1,0,0,0],
        ]


        swift2d.move(.left, id: "m", withCamera: true)
        XCTAssertEqual(expected, swift2d.cameraFrame())

        // off set (col) +2
        swift2d.move(.left, id: "m", withCamera: true)
        swift2d.move(.left, id: "m", withCamera: true)
        XCTAssertEqual(expected, swift2d.cameraFrame())

        // hit wall left
        expected = [
            [0,0,0,0,0],
            [1,0,0,0,0],
            [1,1,0,0,0],
            [1,1,1,0,0],
        ]

        swift2d.move(.down, id: "m", withCamera: true)
        XCTAssertEqual(expected, swift2d.cameraFrame())

        // off set (col) +2
        // collide shape.. wont add to offset count
        swift2d.move(.down, id: "m", withCamera: true)
        swift2d.move(.down, id: "m", withCamera: true)
        XCTAssertEqual(expected, swift2d.cameraFrame())

        // off set (col) +2
        // off set (row) 0
        // collide shape.. wont add to offset count
        swift2d.move(.right, id: "m", withCamera: true)
        swift2d.move(.left, id: "m", withCamera: true)
        XCTAssertEqual(expected, swift2d.cameraFrame())


        expected = [
            [0,0,0,0,0],
            [1,0,0,0,0],
            [1,0,0,0,0],
            [0,1,0,0,0],
        ]


        // off set (col) +2
        // off set (row) 0
        swift2d.move(.up, id: "m", withCamera: true)
        XCTAssertEqual(expected, swift2d.cameraFrame())


        expected = [
            [0,0,0,0,0],
            [0,1,0,0,0],
            [0,1,0,0,0],
            [0,1,0,0,0],
        ]


        // off set (col) +1
        // off set (row) 0
        swift2d.move(.right, id: "m", withCamera: true)
        XCTAssertEqual(expected, swift2d.cameraFrame())

        expected = [
            [0,0,0,0,0],
            [0,0,1,0,0],
            [0,0,1,0,0],
            [0,1,0,0,0],
        ]


        // off set (col) 0
        // off set (row) 0
        swift2d.move(.right, id: "m", withCamera: true)
        XCTAssertEqual(expected, swift2d.cameraFrame())
    }
}
