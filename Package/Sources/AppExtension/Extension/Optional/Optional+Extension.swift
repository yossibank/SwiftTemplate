import Foundation

public extension Bool? {
    var unwraped: Bool {
        self ?? false
    }
}

public extension CGFloat? {
    var unwrapped: CGFloat {
        self ?? 0.0
    }
}

public extension Double? {
    var unwrapped: Double {
        self ?? 0.0
    }

    var toString: String {
        .init(unwrapped)
    }

    var toInt: Int {
        .init(unwrapped)
    }
}

public extension Int? {
    var unwrapped: Int {
        self ?? 0
    }

    var toString: String {
        .init(unwrapped)
    }

    var toDouble: Double {
        .init(unwrapped)
    }

    var toBool: Bool {
        unwrapped.toBool
    }
}

public extension String? {
    var unwrapped: String {
        self ?? ""
    }

    var toInt: Int? {
        unwrapped.toInt
    }

    var toDouble: Double? {
        unwrapped.toDouble
    }

    var isNotEmpty: Bool {
        unwrapped.isNotEmpty
    }
}
