import XCTest
@testable import Swift2D

final class Swift2DTests: XCTestCase {
    
    func test_create_matrix() throws {
        let handler = MatrixHandler(columns: 10, rows: 10)

        XCTAssertEqual(handler.matrix.count, 10)

        handler.matrix.forEach {
            XCTAssertEqual($0.count, 10)
        }
    }

    func test_merge_matrix() throws {
        let handler = MatrixHandler(columns: 10, rows: 10)

        let piece = [
            [0,1,0],
            [1,1,0],
            [0,1,0],
        ]

        handler.merge(piece, column: 2, row: 2)

        var dog = Dog()


        XCTAssertTrue(true)
    }
}

enum Move {
    case left, right, up, down
}

struct Dog {
    let handler = MatrixHandler(columns: 10, rows: 10)

    let piece = [
        [0,1,0],
        [1,1,0],
        [0,1,0],
    ]

    var horizontal = 0
    var vertical = 0

    func render() {
        printAsTable(handler.matrix)
    }

    mutating func move(_ move: Move) {
        
        handler.remove(piece, column: horizontal, row: vertical)

        var newHorizontal = horizontal
        var newVertical = vertical

        switch move {
        case .left:
            newHorizontal -= 1
        case .right:
            newHorizontal += 1
        case .up:
            newVertical -= 1
        case .down:
            newVertical += 1
        }

        let collision = CollisionHandler.collide(handler.matrix, piece, newHorizontal, newVertical)

        if  collision != .none {
            print("colision = \(collision)")
            handler.merge(piece, column: horizontal, row: vertical)
            printAsTable(handler.matrix)
            return
        }

        horizontal = newHorizontal
        vertical = newVertical

        handler.merge(piece, column: horizontal, row: vertical)
        printAsTable(handler.matrix)
    }

    func add() {
        handler.merge(piece, column: 5, row: 5)
    }
}
