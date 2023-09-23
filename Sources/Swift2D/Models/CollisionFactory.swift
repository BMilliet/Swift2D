
public enum CollisionFactory {

    public static func all() -> [CollisionType] {
        return [.ceiling, .floor, .leftWall, .rightWall, .anotherShape]
    }


    public static func wallsAndShapes() -> [CollisionType] {
        return [.leftWall, .rightWall, .anotherShape]
    }


    public static func topDownAndShapes() -> [CollisionType] {
        return [.ceiling, .floor, .anotherShape]
    }
}
