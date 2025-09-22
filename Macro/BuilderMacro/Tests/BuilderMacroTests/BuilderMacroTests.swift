import BuilderMacroMacros
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

let testMacros: [String: Macro.Type] = [
    "Builder": BuilderMacro.self
]

final class BuilderMacroTests: XCTestCase {
    func testBuilderMacroStruct() throws {
        assertMacroExpansion(
            """
            @Builder
            struct User {
                let name: String
                let age: Int
                let hobby: String?
            }
            """,
            expandedSource: """
            struct User {
                let name: String
                let age: Int
                let hobby: String?

                public class Builder {
                    public var name: String
                    public var age: Int
                    public var hobby: String?

                    public init(
                        name: String = "",
                        age: Int = 0,
                        hobby: String? = nil
                    ) {
                        self.name = name
                        self.age = age
                        self.hobby = hobby
                    }

                    public func name(_ name: String) -> Self {
                        self.name = name
                        return self
                    }

                    public func age(_ age: Int) -> Self {
                        self.age = age
                        return self
                    }

                    public func hobby(_ hobby: String?) -> Self {
                        self.hobby = hobby
                        return self
                    }

                    public func build() -> User {
                        return User(
                            name: name,
                            age: age,
                            hobby: hobby
                        )
                    }
                }

                public static func makeTestBuilder() -> Builder {
                    Builder()
                }
            }
            """,
            macros: testMacros
        )
    }

    func testBuilderMacroEnum() throws {
        assertMacroExpansion(
            """
            @Builder
            enum Sample {
                case test1
                case test2umV
                case test3
            }
            """,
            expandedSource: """
            enum Sample {
                case test1
                case test2
                case test3

                public class Builder {
                    public var enumValue: Sample

                    public init(value: Sample = .test1) {
                        self.enumValue = value
                    }

                    public func value(_ value: Sample) -> Self {
                        self.enumValue = value
                        return self
                    }

                    public func build() -> Sample {
                        return enumValue
                    }
                }

                public static func makeTestBuilder() -> Builder {
                    Builder()
                }
            }
            """,
            macros: testMacros
        )
    }

    func testBuilderMacroDefaultArgument() throws {
        assertMacroExpansion(
            """
            @Builder
            struct Argument {
                let argument1: String
                let argument2: Int
                let argument3: UInt
                let argument4: Bool
                let argument5: Double
                let argument6: Float
                let argument7: CGFloat
                let argument8: Date
                let argument9: UUID
                let argument10: Data
                let argument11: URL
                let argument12: CGPoint
                let argument13: CGRect
                let argument14: CGSize
                let argument15: CGVector
                let argument16: UIColor
                let argument17: [String]
                let argument18: [String: String]
                let argument19: () -> Void
                let argument20: (String) -> Void
                let argument21: (String, String) -> Void
                let argument22: String?
                let argument23: String!
            }
            """,
            expandedSource: """
            struct Argument {
                let argument1: String
                let argument2: Int
                let argument3: UInt
                let argument4: Bool
                let argument5: Double
                let argument6: Float
                let argument7: CGFloat
                let argument8: Date
                let argument9: UUID
                let argument10: Data
                let argument11: URL
                let argument12: CGPoint
                let argument13: CGRect
                let argument14: CGSize
                let argument15: CGVector
                let argument16: UIColor
                let argument17: [String]
                let argument18: [String: String]
                let argument19: () -> Void
                let argument20: (String) -> Void
                let argument21: (String, String) -> Void
                let argument22: String?
                let argument23: String!

                public class Builder {
                    public var argument1: String
                    public var argument2: Int
                    public var argument3: UInt
                    public var argument4: Bool
                    public var argument5: Double
                    public var argument6: Float
                    public var argument7: CGFloat
                    public var argument8: Date
                    public var argument9: UUID
                    public var argument10: Data
                    public var argument11: URL
                    public var argument12: CGPoint
                    public var argument13: CGRect
                    public var argument14: CGSize
                    public var argument15: CGVector
                    public var argument16: UIColor
                    public var argument17: [String]
                    public var argument18: [String: String]
                    public var argument19: () -> Void
                    public var argument20: (String) -> Void
                    public var argument21: (String, String) -> Void
                    public var argument22: String?
                    public var argument23: String!

                    public init(
                        argument1: String = "",
                        argument2: Int = 0,
                        argument3: UInt = 0,
                        argument4: Bool = false,
                        argument5: Double = 0,
                        argument6: Float = 0,
                        argument7: CGFloat = 0,
                        argument8: Date = Date(),
                        argument9: UUID = UUID(),
                        argument10: Data = Data(),
                        argument11: URL = URL(string: \"https://www.google.com\")!,
                        argument12: CGPoint = CGPoint(),
                        argument13: CGRect = CGRect(),
                        argument14: CGSize = CGSize(),
                        argument15: CGVector = CGVector(),
                        argument16: UIColor = UIColor.clear,
                        argument17: [String] = [],
                        argument18: [String: String] = [:],
                        argument19: () -> Void = {
                        },
                        argument20: (String) -> Void = { _ in
                        },
                        argument21: (String, String) -> Void = { _, _ in
                        },
                        argument22: String? = nil,
                        argument23: String! = nil
                    ) {
                        self.argument1 = argument1
                        self.argument2 = argument2
                        self.argument3 = argument3
                        self.argument4 = argument4
                        self.argument5 = argument5
                        self.argument6 = argument6
                        self.argument7 = argument7
                        self.argument8 = argument8
                        self.argument9 = argument9
                        self.argument10 = argument10
                        self.argument11 = argument11
                        self.argument12 = argument12
                        self.argument13 = argument13
                        self.argument14 = argument14
                        self.argument15 = argument15
                        self.argument16 = argument16
                        self.argument17 = argument17
                        self.argument18 = argument18
                        self.argument19 = argument19
                        self.argument20 = argument20
                        self.argument21 = argument21
                        self.argument22 = argument22
                        self.argument23 = argument23
                    }

                    public func argument1(_ argument1: String) -> Self {
                        self.argument1 = argument1
                        return self
                    }

                    public func argument2(_ argument2: Int) -> Self {
                        self.argument2 = argument2
                        return self
                    }

                    public func argument3(_ argument3: UInt) -> Self {
                        self.argument3 = argument3
                        return self
                    }

                    public func argument4(_ argument4: Bool) -> Self {
                        self.argument4 = argument4
                        return self
                    }

                    public func argument5(_ argument5: Double) -> Self {
                        self.argument5 = argument5
                        return self
                    }

                    public func argument6(_ argument6: Float) -> Self {
                        self.argument6 = argument6
                        return self
                    }

                    public func argument7(_ argument7: CGFloat) -> Self {
                        self.argument7 = argument7
                        return self
                    }

                    public func argument8(_ argument8: Date) -> Self {
                        self.argument8 = argument8
                        return self
                    }

                    public func argument9(_ argument9: UUID) -> Self {
                        self.argument9 = argument9
                        return self
                    }

                    public func argument10(_ argument10: Data) -> Self {
                        self.argument10 = argument10
                        return self
                    }

                    public func argument11(_ argument11: URL) -> Self {
                        self.argument11 = argument11
                        return self
                    }

                    public func argument12(_ argument12: CGPoint) -> Self {
                        self.argument12 = argument12
                        return self
                    }

                    public func argument13(_ argument13: CGRect) -> Self {
                        self.argument13 = argument13
                        return self
                    }

                    public func argument14(_ argument14: CGSize) -> Self {
                        self.argument14 = argument14
                        return self
                    }

                    public func argument15(_ argument15: CGVector) -> Self {
                        self.argument15 = argument15
                        return self
                    }

                    public func argument16(_ argument16: UIColor) -> Self {
                        self.argument16 = argument16
                        return self
                    }

                    public func argument17(_ argument17: [String]) -> Self {
                        self.argument17 = argument17
                        return self
                    }

                    public func argument18(_ argument18: [String: String]) -> Self {
                        self.argument18 = argument18
                        return self
                    }

                    public func argument19(_ argument19: () -> Void) -> Self {
                        self.argument19 = argument19
                        return self
                    }

                    public func argument20(_ argument20: (String) -> Void) -> Self {
                        self.argument20 = argument20
                        return self
                    }

                    public func argument21(_ argument21: (String, String) -> Void) -> Self {
                        self.argument21 = argument21
                        return self
                    }

                    public func argument22(_ argument22: String?) -> Self {
                        self.argument22 = argument22
                        return self
                    }

                    public func argument23(_ argument23: String!) -> Self {
                        self.argument23 = argument23
                        return self
                    }

                    public func build() -> Argument {
                        return Argument(
                            argument1: argument1,
                            argument2: argument2,
                            argument3: argument3,
                            argument4: argument4,
                            argument5: argument5,
                            argument6: argument6,
                            argument7: argument7,
                            argument8: argument8,
                            argument9: argument9,
                            argument10: argument10,
                            argument11: argument11,
                            argument12: argument12,
                            argument13: argument13,
                            argument14: argument14,
                            argument15: argument15,
                            argument16: argument16,
                            argument17: argument17,
                            argument18: argument18,
                            argument19: argument19,
                            argument20: argument20,
                            argument21: argument21,
                            argument22: argument22,
                            argument23: argument23
                        )
                    }
                }

                public static func makeTestBuilder() -> Builder {
                    Builder()
                }
            }
            """,
            macros: testMacros
        )
    }
}
