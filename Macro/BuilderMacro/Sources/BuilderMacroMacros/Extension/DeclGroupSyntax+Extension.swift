import SwiftSyntax

/**
 * 宣言(Declaration)に関する拡張関数
 * 「struct, class, actor, enum, func, var, protocol...」
 */
extension DeclGroupSyntax {
    /**
     * 宣言名を取得する
     *  struct HOGE {} → HOGE
     *  struct Foo {} → Foo
     */
    var name: String? {
        asProtocol(NamedDeclSyntax.self)?.name.text
    }

    /**
     * 構造体かどうかを判定する
     *  struct HOGE {} → true
     *  class Foo {} → false
     */
    var isStruct: Bool {
        self.as(StructDeclSyntax.self) != nil
    }

    /**
     * stored propertyの変数を全て取得する
     */
    var storedVariables: [VariableDeclSyntax] {
        memberBlock.members
            .compactMap { $0.decl.as(VariableDeclSyntax.self) }
            .filter(\.isStoredProperty)
    }
}
