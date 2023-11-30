public class Camera {
    private var resolution:  Resolution
    private let maxRow: Int
    private let maxCol: Int

    public var getResolution: Resolution { resolution }

    public init(topLeft: Point, bottomRight: Point, maxRow: Int, maxCol: Int) {
        self.resolution = Resolution(topLeft: topLeft, bottomRight: bottomRight)
        self.maxCol = maxCol
        self.maxRow = maxRow
    }

    func move(_ move: Move) {
        var topL    = resolution.topLeft
        var bottomR = resolution.bottomRight

        switch move {
        case .left:
            if topL.column >= maxCol { return }
            topL.column -= 1
            bottomR.column -= 1
        case .right:
            if bottomR.column <= 0 { return }
            topL.column += 1
            bottomR.column += 1
        case .up:
            if topL.row <= 0 { return }
            topL.row -= 1
            bottomR.row -= 1
        case .down:
            if bottomR.row >= maxRow { return }
            topL.row += 1
            bottomR.row += 1
        }

        resolution = Resolution(topLeft: topL, bottomRight: bottomR)
    }
}
