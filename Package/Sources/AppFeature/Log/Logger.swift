import Foundation
import os

public enum Logger {
    public enum Category: String, CaseIterable, Sendable {
        case trace
        case debug
        case info
        case notice
        case warning
        case error
        case critical
        case fault

        public var title: String {
            switch self {
            case .trace: "TRACE"
            case .debug: "DEBUG"
            case .info: "INFO"
            case .notice: "NOTICE"
            case .warning: "WARNING"
            case .error: "ERROR"
            case .critical: "CRITICAL"
            case .fault: "FAULT"
            }
        }
    }
}

private extension Logger {
    static func doLog(
        _ category: Category,
        message: String,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        let prefix = switch category {
        case .trace: "✉️【TRACE】"
        case .debug: "🔍【DEBUG】"
        case .info: "💻【INFO】"
        case .notice: "📢【NOTICE】"
        case .warning: "⚠️【WARNING】"
        case .error: "🚨【ERROR】"
        case .critical: "👿【CRITICAL】"
        case .fault: "💣【FAULT】"
        }

        let logger = os.Logger(
            subsystem: Bundle.main.bundleIdentifier ?? "",
            category: category.rawValue
        )

        let fileName = file.split(separator: "/").last!

        switch category {
        case .trace:
            logger.trace(
                """
                \(prefix, privacy: .public)
                \(message, privacy: .public) 
                📁File: \(fileName, privacy: .public) L:\(line)
                🔔Function: \(function, privacy: .public) 
                """
            )

        case .debug:
            logger.debug(
                """
                \(prefix, privacy: .public)
                \(message, privacy: .public) 
                📁File: \(fileName, privacy: .public) L:\(line)
                🔔Function: \(function, privacy: .public) 
                """
            )

        case .info:
            logger.info(
                """
                \(prefix, privacy: .public)
                \(message, privacy: .public) 
                📁File: \(fileName, privacy: .public) L:\(line)
                🔔Function: \(function, privacy: .public) 
                """
            )

        case .notice:
            logger.notice(
                """
                \(prefix, privacy: .public)
                \(message, privacy: .public) 
                📁File: \(fileName, privacy: .public) L:\(line)
                🔔Function: \(function, privacy: .public) 
                """
            )

        case .warning:
            logger.warning(
                """
                \(prefix, privacy: .public)
                \(message, privacy: .public) 
                📁File: \(fileName, privacy: .public) L:\(line)
                🔔Function: \(function, privacy: .public) 
                """
            )

        case .error:
            logger.error(
                """
                \(prefix, privacy: .public)
                \(message, privacy: .public) 
                📁File: \(fileName, privacy: .public) L:\(line)
                🔔Function: \(function, privacy: .public) 
                """
            )
        case .critical:
            logger.critical(
                """
                \(prefix, privacy: .public)
                \(message, privacy: .public) 
                📁File: \(fileName, privacy: .public) L:\(line)
                🔔Function: \(function, privacy: .public) 
                """
            )

        case .fault:
            logger.fault(
                """
                \(prefix, privacy: .public)
                \(message, privacy: .public) 
                📁File: \(fileName, privacy: .public) L:\(line)
                🔔Function: \(function, privacy: .public) 
                """
            )
        }
    }
}

public extension Logger {
    // only debug
    static func trace(
        message: String,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        doLog(
            .trace,
            message: message,
            file: file,
            function: function,
            line: line
        )
    }

    // only debug
    static func debug(
        message: String,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        doLog(
            .debug,
            message: message,
            file: file,
            function: function,
            line: line
        )
    }

    // only debug
    static func info(
        message: String,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        doLog(
            .info,
            message: message,
            file: file,
            function: function,
            line: line
        )
    }

    static func notice(
        message: String,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        doLog(
            .notice,
            message: message,
            file: file,
            function: function,
            line: line
        )
    }

    static func warning(
        message: String,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        doLog(
            .warning,
            message: message,
            file: file,
            function: function,
            line: line
        )
    }

    static func error(
        message: String,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        doLog(
            .error,
            message: message,
            file: file,
            function: function,
            line: line
        )
    }

    static func critical(
        message: String,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        doLog(
            .critical,
            message: message,
            file: file,
            function: function,
            line: line
        )
    }

    static func fault(
        message: String,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        doLog(
            .fault,
            message: message,
            file: file,
            function: function,
            line: line
        )
    }
}
