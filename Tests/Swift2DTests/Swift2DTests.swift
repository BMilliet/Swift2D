import XCTest
@testable import Swift2D

final class Swift2DTests: XCTestCase {

    func test_basic_movement_in_canvas() throws {

        let controller = CanvasController(columns: 6, rows: 6)

        let matrix = [
            [1,1],
            [1,1],
        ]

        let shape = Shape(id: "m", matrix: matrix, column: 2, row: 2)

        try controller.addToCanvas(shape: shape)

        XCTAssertEqual("m", controller.getShapeKeys.first!)

        var expected = [
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,1,1,0,0],
            [0,0,1,1,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
        ]

        XCTAssertEqual(expected, controller.canvas)

        expected = [
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,1,1,0,0,0],
            [0,1,1,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
        ]
        try controller.move(.left, id: "m")
        XCTAssertEqual(expected, controller.canvas)

        expected = [
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,1,1,0,0],
            [0,0,1,1,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
        ]
        try controller.move(.right, id: "m")
        XCTAssertEqual(expected, controller.canvas)

        expected = [
            [0,0,0,0,0,0],
            [0,0,1,1,0,0],
            [0,0,1,1,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
        ]
        try controller.move(.up, id: "m")
        XCTAssertEqual(expected, controller.canvas)

        expected = [
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,1,1,0,0],
            [0,0,1,1,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
        ]
        try controller.move(.down, id: "m")
        XCTAssertEqual(expected, controller.canvas)

        expected = [
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
        ]
        controller.remove(id: "m")
        XCTAssertEqual(expected, controller.canvas)
        XCTAssertEqual([], controller.getShapeKeys)
    }

    func test_collision_in_canvas() throws {

        let controller = CanvasController(columns: 2, rows: 2)

        let matrix = [
            [1],
        ]

        let shape = Shape(id: "m", matrix: matrix, column: 0, row: 0)

        try controller.addToCanvas(shape: shape)

        var expected = [
            [1,0],
            [0,0]
        ]

        XCTAssertEqual(expected, controller.canvas)

        try controller.move(.left, id: "m")
        XCTAssertEqual(expected, controller.canvas)

        try controller.move(.up, id: "m")
        XCTAssertEqual(expected, controller.canvas)


        expected = [
            [0,0],
            [1,0]
        ]
        try controller.move(.down, id: "m")
        XCTAssertEqual(expected, controller.canvas)
        try controller.move(.down, id: "m")
        XCTAssertEqual(expected, controller.canvas)


        expected = [
            [0,0],
            [0,1]
        ]
        try controller.move(.right, id: "m")
        XCTAssertEqual(expected, controller.canvas)
        try controller.move(.right, id: "m")
        XCTAssertEqual(expected, controller.canvas)
    }

    func test_disabled_collision_in_canvas() throws {

        let controller = CanvasController(columns: 3, rows: 3, collisions: [])

        let matrix = [
            [1,1],
            [1,1],
        ]

        let shape = Shape(id: "m", matrix: matrix, column: 0, row: 0)

        try controller.addToCanvas(shape: shape)

        var expected = [
            [1,1,0],
            [1,1,0],
            [0,0,0],
        ]
        XCTAssertEqual(expected, controller.canvas)

        expected = [
            [1,0,0],
            [1,0,0],
            [0,0,0],
        ]
        try controller.move(.left, id: "m")
        XCTAssertEqual(expected, controller.canvas)

        expected = [
            [0,0,0],
            [0,0,0],
            [0,0,0],
        ]
        try controller.move(.left, id: "m")
        XCTAssertEqual(expected, controller.canvas)

        expected = [
            [1,1,0],
            [1,1,0],
            [0,0,0],
        ]
        try controller.move(.right, id: "m")
        try controller.move(.right, id: "m")
        XCTAssertEqual(expected, controller.canvas)

        expected = [
            [1,1,0],
            [0,0,0],
            [0,0,0],
        ]
        try controller.move(.up, id: "m")
        XCTAssertEqual(expected, controller.canvas)

        expected = [
            [0,0,0],
            [0,0,0],
            [0,0,0],
        ]
        try controller.move(.up, id: "m")
        XCTAssertEqual(expected, controller.canvas)

        expected = [
            [0,0,0],
            [0,0,0],
            [1,1,0],
        ]
        try controller.move(.down, id: "m")
        try controller.move(.down, id: "m")
        try controller.move(.down, id: "m")
        try controller.move(.down, id: "m")
        XCTAssertEqual(expected, controller.canvas)

        expected = [
            [0,0,0],
            [0,0,0],
            [0,0,1],
        ]
        try controller.move(.right, id: "m")
        try controller.move(.right, id: "m")
        XCTAssertEqual(expected, controller.canvas)
    }

    func test_collision_with_matrix() throws {

        let controller = CanvasController(columns: 6, rows: 6)

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

        try controller.addToCanvas(shape: shapeM)
        try controller.addToCanvas(shape: shapeN)

        var expected = [
            [0,0,1,1,1,0],
            [0,0,0,1,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,1,0],
            [0,0,0,0,1,0],
            [0,0,0,1,1,0],
        ]
        XCTAssertEqual(expected, controller.canvas)
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
        try controller.move(.down, id: "m")
        XCTAssertEqual(.none, shapeM.lastCollision)
        XCTAssertEqual(.none, shapeN.lastCollision)
        XCTAssertTrue(shapeM.lastCollidedShape.isEmpty)
        XCTAssertTrue(shapeN.lastCollidedShape.isEmpty)

        try controller.move(.down, id: "m")
        XCTAssertEqual(.none, shapeM.lastCollision)
        XCTAssertEqual(.none, shapeN.lastCollision)
        XCTAssertTrue(shapeM.lastCollidedShape.isEmpty)
        XCTAssertTrue(shapeN.lastCollidedShape.isEmpty)

        try controller.move(.down, id: "m")
        XCTAssertEqual(.anotherShape, shapeM.lastCollision)
        XCTAssertEqual(.anotherShape, shapeN.lastCollision)
        XCTAssertEqual("n", shapeM.lastCollidedShape)
        XCTAssertEqual("m", shapeN.lastCollidedShape)
        XCTAssertEqual(expected, controller.canvas)

        try controller.move(.right, id: "m")
        XCTAssertEqual(expected, controller.canvas)

        expected = [
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [1,1,1,0,1,0],
            [0,1,0,0,1,0],
            [0,0,0,1,1,0],
        ]
        try controller.move(.left, id: "m")
        try controller.move(.left, id: "m")
        try controller.move(.down, id: "m")

        XCTAssertEqual(.none, shapeM.lastCollision)
        XCTAssertEqual(.none, shapeN.lastCollision)
        XCTAssertEqual("", shapeM.lastCollidedShape)
        XCTAssertEqual("", shapeN.lastCollidedShape)

        XCTAssertEqual(expected, controller.canvas)

        try controller.move(.left, id: "m")

        XCTAssertEqual(.leftWall, shapeM.lastCollision)
        XCTAssertEqual(.none, shapeN.lastCollision)
        XCTAssertEqual("", shapeM.lastCollidedShape)
        XCTAssertEqual("", shapeN.lastCollidedShape)

        XCTAssertEqual(expected, controller.canvas)

        expected = [
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,1,1,1,1,0],
            [0,0,1,0,1,0],
            [0,0,0,1,1,0],
        ]
        try controller.move(.right, id: "m")
        try controller.move(.right, id: "m")

        XCTAssertEqual(.anotherShape, shapeM.lastCollision)
        XCTAssertEqual(.anotherShape, shapeN.lastCollision)
        XCTAssertEqual("n", shapeM.lastCollidedShape)
        XCTAssertEqual("m", shapeN.lastCollidedShape)

        XCTAssertEqual(expected, controller.canvas)
    }
}
