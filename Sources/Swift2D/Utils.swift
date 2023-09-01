
let SHAPE_DEFAULT_X: Int = 5
let SHAPE_DEFAULT_Y: Int = -2

func createEmptyMatrix(_ columns: Int, _ rows: Int) -> [[Int]] {
    var matrix = [[Int]]()

    for _ in 0..<rows {
        var row = [Int]()

        for _ in 0..<columns {
            row.append(0)
        }

        matrix.append(row)
    }

    return matrix
}

func printAsTable(_ m: [[Int]]) {
    var line = ""
    print("===========================")

    m.forEach { row in
        row.forEach {
            line += "\($0) "
        }
        print(line)
        line = ""
    }
}
