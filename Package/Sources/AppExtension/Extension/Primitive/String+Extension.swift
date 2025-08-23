public extension String {
    var toInt: Int? {
        .init(self)
    }

    var toDouble: Double? {
        .init(self)
    }

    var isNotEmpty: Bool {
        !isEmpty
    }
}
