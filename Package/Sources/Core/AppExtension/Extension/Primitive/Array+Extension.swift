public extension Array {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

public extension Array {
    var isNotEmpty: Bool {
        !isEmpty
    }
}
