public class Camera {
    private var resolution:  Resolution
    private let rowDistance: Int
    private let colDistance: Int

    public var getResolution: Resolution { resolution }

    public init(topLeft: Point, bottomRight: Point) {

        self.resolution = Resolution(topLeft: topLeft, bottomRight: bottomRight)

        rowDistance = Array(topLeft.row..<bottomRight.row).count
        colDistance = Array(topLeft.column..<bottomRight.column).count
    }

    func move(_ move: Move) {
        var topL    = resolution.topLeft
        var bottomR = resolution.bottomRight

        switch move {
        case .left:
            topL.column -= 1
            bottomR.column -= 1
        case .right:
            topL.column += 1
            bottomR.column += 1
        case .up:
            topL.row -= 1
            bottomR.row -= 1
        case .down:
            topL.row += 1
            bottomR.row += 1
        }

        resolution = Resolution(topLeft: topL, bottomRight: bottomR)
    }
}
