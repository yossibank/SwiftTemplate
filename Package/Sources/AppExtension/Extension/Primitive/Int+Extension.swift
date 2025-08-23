public extension Int {
    var toString: String {
        .init(self)
    }

    var toDouble: Double {
        .init(self)
    }

    var toBool: Bool {
        self == 1
    }
}
