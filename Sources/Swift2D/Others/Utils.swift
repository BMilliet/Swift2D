func createEmptyCanvas(_ columns: Int, _ rows: Int) -> [[Int]] {
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


func stringMatrix(_ m: [[Int]]) -> String {
    var line = ""
    var matrix = ""

    m.forEach { row in
        row.forEach {
            line += "\($0) "
        }
        matrix += "\(line)\n"
        line = ""
    }

    return matrix
}
