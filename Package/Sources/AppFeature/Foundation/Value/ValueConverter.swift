import Foundation

public struct ValueConverter {
    public struct Formatter {
        public let value: Double?
        public let valueFormat: ValueFormat
        public let nullValue: String

        public init(
            value: Double?,
            valueFormat: ValueFormat = .init(),
            nullValue: String = "---"
        ) {
            self.value = value
            self.valueFormat = valueFormat
            self.nullValue = nullValue
        }
    }

    public init() {}
}

private extension ValueConverter {
    func decimalNumberHandler(scale: Int) -> NSDecimalNumberHandler {
        .init(
            roundingMode: .plain,
            scale: .init(scale),
            raiseOnExactness: false,
            raiseOnOverflow: false,
            raiseOnUnderflow: false,
            raiseOnDivideByZero: false
        )
    }
}

public extension ValueConverter {
    func format(_ formatter: Formatter) -> String {
        let format = formatter.valueFormat
        let nullValue = formatter.nullValue

        guard let value = formatter.value else {
            return format.prefix.value + nullValue + format.suffix.value
        }

        let formatter = NumberFormatter().apply {
            $0.numberStyle = .decimal
        }

        let scaleValue = NSDecimalNumber(string: String(value))
            .rounding(accordingToBehavior: decimalNumberHandler(scale: format.scale))
            .doubleValue

        let formattedValue = String(
            format: "%.\(format.scale)f",
            scaleValue
        )

        let doubleValue = Double(
            formattedValue.split(separator: ".").first.map(String.init) ?? ""
        ) ?? value

        let firstValue = formatter.string(
            from: .init(value: doubleValue)
        ) ?? nullValue

        let lastValue = if format.scale == 0 || scaleValue == 0 {
            ""
        } else {
            "." + (formattedValue.split(separator: ".").last.map(String.init) ?? "")
        }

        let prefix = if value > 0 {
            format.prefix.value
        } else {
            ""
        }

        let suffix = format.suffix.value

        return prefix + firstValue + lastValue + suffix
    }
}
