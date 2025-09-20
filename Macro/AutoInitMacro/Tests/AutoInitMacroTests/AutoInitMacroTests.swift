import AutoInitMacroMacros
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

let testMacros: [String: Macro.Type] = [
    "AutoInit": AutoInitMacro.self,
    "Init": InitMacro.self
]

final class AutoInitMacroTests: XCTestCase {
    func testAutoInitMacro() throws {
        assertMacroExpansion(
            """
            @AutoInit
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

                public init(
                    name: String,
                    age: Int,
                    hobby: String?
                ) {
                    self.name = name
                    self.age = age
                    self.hobby = hobby
                }
            }
            """,
            macros: testMacros
        )
    }

    func testInitMacro() throws {
        assertMacroExpansion(
            """
            @AutoInit
            struct User {
                @Init(label: "foo") let name: String
                @Init(default: 20) let age: Int
                @Init(label: "hoge", default: "soccer") let hobby: String?
                let anyProtocol: any AnyProtocol
                let someProtocol: some SomeProtocol
                let closure: () -> Void
            }
            """,
            expandedSource: """
            struct User {
                let name: String
                let age: Int
                let hobby: String?
                let anyProtocol: any AnyProtocol
                let someProtocol: some SomeProtocol
                let closure: () -> Void

                public init(
                    foo name: String,
                    age: Int = 20,
                    hoge hobby: String? = "soccer",
                    anyProtocol: any AnyProtocol,
                    someProtocol: some SomeProtocol,
                    closure: @escaping () -> Void
                ) {
                    self.name = name
                    self.age = age
                    self.hobby = hobby
                    self.anyProtocol = anyProtocol
                    self.someProtocol = someProtocol
                    self.closure = closure
                }
            }
            """,
            macros: testMacros
        )
    }

    func testInitUnderScoreMacro() throws {
        assertMacroExpansion(
            """
            @AutoInit
            struct User {
                @Init(label: "_") let name: String
                @Init(label: "_", default: 20) let age: Int
                let hobby: String?
            }
            """,
            expandedSource: """
            struct User {
                let name: String
                let age: Int
                let hobby: String?

                public init(
                    _ name: String,
                    _ age: Int = 20,
                    hobby: String?
                ) {
                    self.name = name
                    self.age = age
                    self.hobby = hobby
                }
            }
            """,
            macros: testMacros
        )
    }
}
