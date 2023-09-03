import XCTest
@testable import Swift2D

final class Swift2DTests: XCTestCase {
    
    func test_create_canvas() throws {
        let handler = CanvasHandler()
        handler.createCanvas(columns: 10, rows: 10)

        XCTAssertEqual(handler.canvas.count, 10)

        handler.canvas.forEach {
            XCTAssertEqual($0.count, 10)
        }
    }

    func test_basic_movement_in_canvas() throws {

        let controller = CanvasController(columns: 6, rows: 6)

        let matrix = [
            [1,1],
            [1,1],
        ]

        let shape = Shape(id: "m", matrix: matrix, column: 2, row: 2)

        try controller.addToCanvas(shape: shape)

        var expected = [
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,1,1,0,0],
            [0,0,1,1,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
        ]

        XCTAssertEqual(expected, controller.canvas)

        try controller.move(.left, id: "m")

        expected = [
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,1,1,0,0,0],
            [0,1,1,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
        ]

        XCTAssertEqual(expected, controller.canvas)

        try controller.move(.right, id: "m")

        expected = [
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,1,1,0,0],
            [0,0,1,1,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
        ]

        XCTAssertEqual(expected, controller.canvas)

        try controller.move(.up, id: "m")

        expected = [
            [0,0,0,0,0,0],
            [0,0,1,1,0,0],
            [0,0,1,1,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
        ]

        XCTAssertEqual(expected, controller.canvas)

        try controller.move(.down, id: "m")

        expected = [
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,1,1,0,0],
            [0,0,1,1,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
        ]

        XCTAssertEqual(expected, controller.canvas)
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

        try controller.move(.down, id: "m")

        expected = [
            [0,0],
            [1,0]
        ]

        XCTAssertEqual(expected, controller.canvas)
        try controller.move(.down, id: "m")
        XCTAssertEqual(expected, controller.canvas)

        try controller.move(.right, id: "m")

        expected = [
            [0,0],
            [0,1]
        ]

        XCTAssertEqual(expected, controller.canvas)
        try controller.move(.right, id: "m")
        XCTAssertEqual(expected, controller.canvas)

        XCTAssertTrue(true)
    }
}
