import SwiftSyntax

/**
 * 宣言(Declaration)に関する拡張関数
 * 「struct, class, actor, enum, func, var, protocol...」
 */
extension DeclGroupSyntax {
    /**
     * 構造体かどうかを判定する
     *  struct HOGE {} → true
     *  class Foo {} → false
     */
    var isStruct: Bool {
        self.as(StructDeclSyntax.self) != nil
    }

    /**
     * クラスかどうかを判定する
     *  struct HOGE {} → false
     *  class Foo {} → true
     */
    var isClass: Bool {
        self.as(ClassDeclSyntax.self) != nil
    }

    /**
     * アクターかどうかを判定する
     *  actor HOGE {} → true
     *  class Foo {} → false
     */
    var isActor: Bool {
        self.as(ActorDeclSyntax.self) != nil
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
