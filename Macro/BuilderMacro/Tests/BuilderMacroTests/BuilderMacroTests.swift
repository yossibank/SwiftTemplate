import BuilderMacroMacros
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

let testMacros: [String: Macro.Type] = [
    "Builder": BuilderMacro.self
]

final class BuilderMacroTests: XCTestCase {
    func testBuilderMacro() throws {
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
                    public var name: String?
                    public var age: Int?
                    public var hobby: String?

                    public init() {
                    }

                    public convenience init(_ item: User?) {
                        self.init()
                        fill(with: item)
                    }

                    public func fill(with item: User?) {
                        name = item?.name
                        age = item?.age
                        hobby = item?.hobby
                    }

                    public func name(_ name: String?) -> Self {
                        self.name = name
                        return self
                    }

                    public func age(_ age: Int?) -> Self {
                        self.age = age
                        return self
                    }

                    public func hobby(_ hobby: String?) -> Self {
                        self.hobby = hobby
                        return self
                    }

                    public func build() -> User? {
                        guard let name, let age else {
                            return nil
                        }
                        return User(
                            name: name,
                            age: age,
                            hobby: hobby
                        )
                    }
                }

                public static func makeBuilder() -> Builder {
                    Builder()
                }
            }
            """,
            macros: testMacros
        )
    }
}
