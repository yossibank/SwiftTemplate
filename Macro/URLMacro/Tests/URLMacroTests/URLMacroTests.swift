import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import URLMacroMacros
import XCTest

final class URLMacroTests: XCTestCase {
    let testMacros: [String: Macro.Type] = [
        "URL": URLMacro.self
    ]

    func testValidHTTPSURL() throws {
        assertMacroExpansion(
            """
            #URL("https://www.example.com")
            """,
            expandedSource: """
            URL(string: "https://www.example.com")!
            """,
            macros: testMacros
        )
    }

    func testValidHTTPURL() throws {
        assertMacroExpansion(
            """
            #URL("http://localhost:8080")
            """,
            expandedSource: """
            URL(string: "http://localhost:8080")!
            """,
            macros: testMacros
        )
    }

    func testValidURLWithPath() throws {
        assertMacroExpansion(
            """
            #URL("https://api.example.com/v1/users")
            """,
            expandedSource: """
            URL(string: "https://api.example.com/v1/users")!
            """,
            macros: testMacros
        )
    }

    func testValidURLWithQuery() throws {
        assertMacroExpansion(
            """
            #URL("https://example.com/search?q=swift&page=1")
            """,
            expandedSource: """
            URL(string: "https://example.com/search?q=swift&page=1")!
            """,
            macros: testMacros
        )
    }

    func testValidURLWithFragment() throws {
        assertMacroExpansion(
            """
            #URL("https://example.com/docs#section1")
            """,
            expandedSource: """
            URL(string: "https://example.com/docs#section1")!
            """,
            macros: testMacros
        )
    }

    func testValidURLWithPort() throws {
        assertMacroExpansion(
            """
            #URL("https://example.com:443/api")
            """,
            expandedSource: """
            URL(string: "https://example.com:443/api")!
            """,
            macros: testMacros
        )
    }

    func testValidURLWithSubdomain() throws {
        assertMacroExpansion(
            """
            #URL("https://api.staging.example.com")
            """,
            expandedSource: """
            URL(string: "https://api.staging.example.com")!
            """,
            macros: testMacros
        )
    }

    func testMissingArgument() throws {
        assertMacroExpansion(
            """
            #URL()
            """,
            expandedSource: """
            #URL()
            """,
            diagnostics: [
                DiagnosticSpec(
                    message: "URL macro requires a string argument",
                    line: 1,
                    column: 1
                )
            ],
            macros: testMacros
        )
    }

    func testNonStringArgument() throws {
        assertMacroExpansion(
            """
            #URL(42)
            """,
            expandedSource: """
            #URL(42)
            """,
            diagnostics: [
                DiagnosticSpec(
                    message: "URL macro argument must be a string literal",
                    line: 1,
                    column: 1
                )
            ],
            macros: testMacros
        )
    }

    func testStringInterpolationArgument() throws {
        assertMacroExpansion(
            """
            #URL("https://\\(domain).com")
            """,
            expandedSource: """
            #URL("https://\\(domain).com")
            """,
            diagnostics: [
                DiagnosticSpec(
                    message: "URL macro argument must be a string literal",
                    line: 1,
                    column: 1
                )
            ],
            macros: testMacros
        )
    }

    func testInvalidURL() throws {
        assertMacroExpansion(
            """
            #URL("not a valid url")
            """,
            expandedSource: """
            #URL("not a valid url")
            """,
            diagnostics: [
                DiagnosticSpec(
                    message: "URL scheme must be 'http' or 'https'",
                    line: 1,
                    column: 1
                )
            ],
            macros: testMacros
        )
    }

    func testInvalidScheme() throws {
        assertMacroExpansion(
            """
            #URL("ftp://example.com")
            """,
            expandedSource: """
            #URL("ftp://example.com")
            """,
            diagnostics: [
                DiagnosticSpec(
                    message: "URL scheme must be 'http' or 'https'",
                    line: 1,
                    column: 1
                )
            ],
            macros: testMacros
        )
    }

    func testMissingScheme() throws {
        assertMacroExpansion(
            """
            #URL("example.com")
            """,
            expandedSource: """
            #URL("example.com")
            """,
            diagnostics: [
                DiagnosticSpec(
                    message: "URL scheme must be 'http' or 'https'",
                    line: 1,
                    column: 1
                )
            ],
            macros: testMacros
        )
    }

    func testEmptyHost() throws {
        assertMacroExpansion(
            """
            #URL("https://")
            """,
            expandedSource: """
            #URL("https://")
            """,
            diagnostics: [
                DiagnosticSpec(
                    message: "URL must have a valid host",
                    line: 1,
                    column: 1
                )
            ],
            macros: testMacros
        )
    }

    func testInvalidHost() throws {
        assertMacroExpansion(
            """
            #URL("https://")
            """,
            expandedSource: """
            #URL("https://")
            """,
            diagnostics: [
                DiagnosticSpec(
                    message: "URL must have a valid host",
                    line: 1,
                    column: 1
                )
            ],
            macros: testMacros
        )
    }

    func testLocalhostURL() throws {
        assertMacroExpansion(
            """
            #URL("http://localhost")
            """,
            expandedSource: """
            URL(string: "http://localhost")!
            """,
            macros: testMacros
        )
    }

    func testIPAddressURL() throws {
        assertMacroExpansion(
            """
            #URL("https://192.168.1.1")
            """,
            expandedSource: """
            URL(string: "https://192.168.1.1")!
            """,
            macros: testMacros
        )
    }

    func testComplexURL() throws {
        assertMacroExpansion(
            """
            #URL("https://user:pass@example.com:8080/path/to/resource?param1=value1&param2=value2#section")
            """,
            expandedSource: """
            URL(string: "https://user:pass@example.com:8080/path/to/resource?param1=value1&param2=value2#section")!
            """,
            macros: testMacros
        )
    }

    func testURLWithUnicodeCharacters() throws {
        assertMacroExpansion(
            """
            #URL("https://example.com/パス")
            """,
            expandedSource: """
            URL(string: "https://example.com/パス")!
            """,
            macros: testMacros
        )
    }
}
