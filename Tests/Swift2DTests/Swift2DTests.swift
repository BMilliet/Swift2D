import XCTest
@testable import Swift2D

final class Swift2DTests: XCTestCase {

    func test_basic_movement_in_canvas() throws {

        let swift2d = Swift2D(columns: 6, rows: 6)

        let matrix = [
            [1,1],
            [1,1],
        ]

        let shape = Shape(id: "m", matrix: matrix, column: 2, row: 2)

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
        try swift2d.move(.left, id: "m")
        XCTAssertEqual(expected, swift2d.canvas)

        expected = [
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,1,1,0,0],
            [0,0,1,1,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
        ]
        try swift2d.move(.right, id: "m")
        XCTAssertEqual(expected, swift2d.canvas)

        expected = [
            [0,0,0,0,0,0],
            [0,0,1,1,0,0],
            [0,0,1,1,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
        ]
        try swift2d.move(.up, id: "m")
        XCTAssertEqual(expected, swift2d.canvas)

        expected = [
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,1,1,0,0],
            [0,0,1,1,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
        ]
        try swift2d.move(.down, id: "m")
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

        let shape = Shape(id: "m", matrix: matrix, column: 0, row: 0)

        try swift2d.addToCanvas(shape: shape)

        var expected = [
            [1,0],
            [0,0]
        ]

        XCTAssertEqual(expected, swift2d.canvas)

        try swift2d.move(.left, id: "m")
        XCTAssertEqual(expected, swift2d.canvas)

        try swift2d.move(.up, id: "m")
        XCTAssertEqual(expected, swift2d.canvas)


        expected = [
            [0,0],
            [1,0]
        ]
        try swift2d.move(.down, id: "m")
        XCTAssertEqual(expected, swift2d.canvas)
        try swift2d.move(.down, id: "m")
        XCTAssertEqual(expected, swift2d.canvas)


        expected = [
            [0,0],
            [0,1]
        ]
        try swift2d.move(.right, id: "m")
        XCTAssertEqual(expected, swift2d.canvas)
        try swift2d.move(.right, id: "m")
        XCTAssertEqual(expected, swift2d.canvas)
    }

    func test_disabled_collision_in_canvas() throws {

        let swift2d = Swift2D(columns: 3, rows: 3, collisions: [])

        let matrix = [
            [1,1],
            [1,1],
        ]

        let shape = Shape(id: "m", matrix: matrix, column: 0, row: 0)

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
        try swift2d.move(.left, id: "m")
        XCTAssertEqual(expected, swift2d.canvas)

        expected = [
            [0,0,0],
            [0,0,0],
            [0,0,0],
        ]
        try swift2d.move(.left, id: "m")
        XCTAssertEqual(expected, swift2d.canvas)

        expected = [
            [1,1,0],
            [1,1,0],
            [0,0,0],
        ]
        try swift2d.move(.right, id: "m")
        try swift2d.move(.right, id: "m")
        XCTAssertEqual(expected, swift2d.canvas)

        expected = [
            [1,1,0],
            [0,0,0],
            [0,0,0],
        ]
        try swift2d.move(.up, id: "m")
        XCTAssertEqual(expected, swift2d.canvas)

        expected = [
            [0,0,0],
            [0,0,0],
            [0,0,0],
        ]
        try swift2d.move(.up, id: "m")
        XCTAssertEqual(expected, swift2d.canvas)

        expected = [
            [0,0,0],
            [0,0,0],
            [1,1,0],
        ]
        try swift2d.move(.down, id: "m")
        try swift2d.move(.down, id: "m")
        try swift2d.move(.down, id: "m")
        try swift2d.move(.down, id: "m")
        XCTAssertEqual(expected, swift2d.canvas)

        expected = [
            [0,0,0],
            [0,0,0],
            [0,0,1],
        ]
        try swift2d.move(.right, id: "m")
        try swift2d.move(.right, id: "m")
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

        let shapeM = Shape(id: "m", matrix: matrix1, column: 2, row: 0)
        let shapeN = Shape(id: "n", matrix: matrix2, column: 3, row: 3)

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
        try swift2d.move(.down, id: "m")
        XCTAssertEqual(.none, shapeM.lastCollision)
        XCTAssertEqual(.none, shapeN.lastCollision)
        XCTAssertTrue(shapeM.lastCollidedShape.isEmpty)
        XCTAssertTrue(shapeN.lastCollidedShape.isEmpty)
        XCTAssertNil(shapeM.lastCollidedPoint)
        XCTAssertNil(shapeN.lastCollidedPoint)

        try swift2d.move(.down, id: "m")
        XCTAssertEqual(.none, shapeM.lastCollision)
        XCTAssertEqual(.none, shapeN.lastCollision)
        XCTAssertTrue(shapeM.lastCollidedShape.isEmpty)
        XCTAssertTrue(shapeN.lastCollidedShape.isEmpty)

        try swift2d.move(.down, id: "m")
        XCTAssertEqual(.anotherShape, shapeM.lastCollision)
        XCTAssertEqual(.anotherShape, shapeN.lastCollision)
        XCTAssertEqual("n", shapeM.lastCollidedShape)
        XCTAssertEqual("m", shapeN.lastCollidedShape)
        XCTAssertEqual(Point(column: 4, row: 3), shapeN.lastCollidedPoint)
        XCTAssertEqual(Point(column: 4, row: 3), shapeM.lastCollidedPoint)
        XCTAssertEqual(expected, swift2d.canvas)

        try swift2d.move(.right, id: "m")
        XCTAssertEqual(expected, swift2d.canvas)

        expected = [
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [1,1,1,0,1,0],
            [0,1,0,0,1,0],
            [0,0,0,1,1,0],
        ]
        try swift2d.move(.left, id: "m")
        try swift2d.move(.left, id: "m")
        try swift2d.move(.down, id: "m")

        XCTAssertEqual(.none, shapeM.lastCollision)
        XCTAssertEqual(.none, shapeN.lastCollision)
        XCTAssertEqual("", shapeM.lastCollidedShape)
        XCTAssertEqual("", shapeN.lastCollidedShape)
        XCTAssertNil(shapeM.lastCollidedPoint)
        XCTAssertNil(shapeN.lastCollidedPoint)

        XCTAssertEqual(expected, swift2d.canvas)

        try swift2d.move(.left, id: "m")

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
        try swift2d.move(.right, id: "m")
        try swift2d.move(.right, id: "m")

        XCTAssertEqual(.anotherShape, shapeM.lastCollision)
        XCTAssertEqual(.anotherShape, shapeN.lastCollision)
        XCTAssertEqual("n", shapeM.lastCollidedShape)
        XCTAssertEqual("m", shapeN.lastCollidedShape)
        XCTAssertEqual(Point(column: 4, row: 3), shapeN.lastCollidedPoint)
        XCTAssertEqual(Point(column: 4, row: 3), shapeM.lastCollidedPoint)

        XCTAssertEqual(expected, swift2d.canvas)
    }
}
