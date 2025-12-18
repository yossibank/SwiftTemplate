import Foundation

public extension Date {
    var epoch: Int64 {
        Int64(timeIntervalSince1970)
    }
}
