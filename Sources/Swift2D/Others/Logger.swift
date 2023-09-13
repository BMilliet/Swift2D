struct Logger {

    var quiet = true

    func log(_ msg: String) {
        if !quiet {
            print(msg)
        }
    }
}
