import Foundation


public struct Point: Hashable, Comparable {

    public var column: Int
    public var row: Int


    public init(column: Int, row: Int) {
        self.column = column
        self.row = row
    }


    public static func < (lhs: Point, rhs: Point) -> Bool {
        if lhs.row == rhs.row {
            return lhs.column < rhs.column
        } else {
            return lhs.row < rhs.row
        }
    }
}
