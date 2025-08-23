import Foundation

public enum DateFormat: String, CaseIterable {
    case hJp
    case hhMMJp
    case dJp
    case mJp
    case mmddJp
    case mmddEHHmmssSSS
    case yyyyJp
    case yyyyMdJp
    case yyyyMMddHHmmss

    var value: String {
        switch self {
        case .hJp: "H時"
        case .hhMMJp: "HH時mm分"
        case .dJp: "d日"
        case .mJp: "M月"
        case .mmddJp: "MM月dd日"
        case .mmddEHHmmssSSS: "MM/dd(E) HH:mm:ss.SSS"
        case .yyyyJp: "yyyy年"
        case .yyyyMdJp: "yyyy年M月d日"
        case .yyyyMMddHHmmss: "yyyy/MM/dd HH:mm:ss"
        }
    }

    static let all = [
        "yyyy/M/d",
        "yyyy/M/d H:mm",
        "yyyyMMdd",
        "yyyy/MM/dd",
        "yyyy-MM-dd",
        "yyyy/MM/dd HH:mm",
        "yyyy-MM-dd HH:mm",
        "yyyy/MM/dd HH:mm:ss",
        "yyyy-MM-dd HH:mm:ss"
    ]
}
