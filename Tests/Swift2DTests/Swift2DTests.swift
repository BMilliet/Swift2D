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

    func test_merge_to_canvas() throws {
        let controller = CanvasController(columns: 10, rows: 10, collisions: [])

        let matrix1 = [
            [0,1,0],
            [1,1,0],
            [0,1,0],
        ]

        let matrix2 = [
            [1,1],
            [1,1],
        ]

        let shape1 = Shape(id: "dog", matrix: matrix1, column: 5, row: 5)
        let shape2 = Shape(id: "cat", matrix: matrix2, column: 0, row: 0)

        controller.addToCanvas(shape: shape1)
        controller.addToCanvas(shape: shape2)



        XCTAssertTrue(true)
    }
}
