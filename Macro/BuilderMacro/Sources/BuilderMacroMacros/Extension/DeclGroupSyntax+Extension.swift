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
     * enumかどうかを判定する
     * enum Sample {} → true
     * struct Foo {} → false
     */
    var isEnum: Bool {
        self.as(EnumDeclSyntax.self) != nil
    }

    /**
     * enumの最初に定義されたcase名を取得する
     * enum Sample {
     *     case test1 → 取得
     *     case test2
     * }
     */
    var firstEnumCase: String? {
        guard let enumDecl = self.as(EnumDeclSyntax.self) else {
            return nil
        }

        for member in enumDecl.memberBlock.members {
            if let enumCase = member.decl.as(EnumCaseDeclSyntax.self),
               let firstElement = enumCase.elements.first {
                return firstElement.name.text
            }
        }

        return nil
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
