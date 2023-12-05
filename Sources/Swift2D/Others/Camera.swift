public class Camera {
    private var resolution:  Resolution
    private let maxRow: Int
    private let maxCol: Int

    private var offsetLimitRow: Int = 0
    private var offsetLimitCol: Int = 0
    private var offsetRow: Int = 0
    private var offsetCol: Int = 0

    public var getResolution: Resolution { resolution }
    public var getCurrentOffset: (Int, Int) { (offsetCol, offsetRow) }

    public init(topLeft: Point, bottomRight: Point, maxRow: Int, maxCol: Int) {
        self.resolution = Resolution(topLeft: topLeft, bottomRight: bottomRight)
        self.maxCol = maxCol
        self.maxRow = maxRow
    }


    public func setOffsetLimits(row: Int, col: Int) {
        offsetLimitCol = col
        offsetLimitRow = row
        offsetCol = offsetLimitCol
        offsetRow = offsetLimitRow
    }


    func move(_ move: Move) {
        var topL    = resolution.topLeft
        var bottomR = resolution.bottomRight

        switch move {
        case .left:
            if topL.column <= 0 {
                if abs(offsetCol) >= offsetLimitCol {
                    offsetCol -= 1
                }
                return
            }

            if offsetCol < offsetLimitCol {
                offsetCol += 1
                return
            }

            topL.column -= 1
            bottomR.column -= 1
        case .right:
            if bottomR.column >= maxCol {
                if abs(offsetCol) >= offsetLimitCol {
                    offsetCol -= 1
                }
                return
            }
            if offsetCol < offsetLimitCol {
                offsetCol += 1
                return
            }
            topL.column += 1
            bottomR.column += 1
        case .up:
            if topL.row <= 0 {
                if abs(offsetRow) >= offsetLimitRow {
                    offsetRow -= 1
                }
                return
            }
            if offsetRow < offsetLimitRow {
                offsetRow += 1
                return
            }
            topL.row -= 1
            bottomR.row -= 1
        case .down:
            if bottomR.row >= maxRow {
                if abs(offsetRow) >= offsetLimitRow {
                    offsetRow -= 1
                }
                return
            }
            if offsetRow < offsetLimitRow {
                offsetRow += 1
                return
            }
            topL.row += 1
            bottomR.row += 1
        }

        resolution = Resolution(topLeft: topL, bottomRight: bottomR)
    }
}
