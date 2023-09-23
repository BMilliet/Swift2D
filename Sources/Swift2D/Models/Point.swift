import Foundation


public struct Point: Hashable, Comparable {
    public let column: Int
    public let row: Int


    public static func < (lhs: Point, rhs: Point) -> Bool {
        if lhs.row == rhs.row {
            return lhs.column < rhs.column
        } else {
            return lhs.row < rhs.row
        }
    }
}
