# Swift2D (2D arrays)

This package focus on handleling 2D arrays in a friendly way, creating an engine for 2D games.
With this package is possible to create a main grid (canvas) and move inner grids inside.

### Usage

Create a main `grid/canvas`:

```swift

// create a grid with 32/32

let swift2d = Swift2D(columns: 32, rows: 32, log: true)

// create a smaller grid/shape and merge it to the main grid in the center

let matrix = [
    [1,1,1],
    [1,1,1]
]

let shape = Swift2DShape(id: "sample", matrix: matrix, column: 32/2, row: 32/2, collisions: CollisionFactory.wallsAndShapes())
try? swift2d.addToCanvas(shape: shape)

// now we can move the `shape` to some direction:

try? swift2d.move(.up, id: "sample")

// we can check how is the main grid looking by:

swift2d.printCanvas()

// or we can directly access it if needed to render in some view:

swift2d.canvas

// its possible to check the shaped that are inside of the main grid:

// get the occupied points(column/row)
swift2d.getPoints

// get the shape map
swift2d.getShapes

// get the shape ids
swift2d.getShapeKeys

// and we can remove the shape:
swift2d.remove(id: "sample")
```
