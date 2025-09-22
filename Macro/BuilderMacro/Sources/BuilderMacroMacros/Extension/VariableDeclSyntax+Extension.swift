import SwiftSyntax

/**
 * 変数・プロパティ(Variable)に関する拡張関数
 * 「var, let」
 */
extension VariableDeclSyntax {
    /**
     * 変数名を取得する
     *  var name: String → name
     *  let age: Int? → age
     */
    var name: String? {
        bindings.first?.pattern.as(
            IdentifierPatternSyntax.self
        )?.identifier.text
    }

    /**
     * 型名を取得する
     *  var name: String → String
     *  let age: Int → Int
     */
    var typeString: String? {
        typeSyntax?.description
    }

    private var typeSyntax: TypeSyntax? {
        bindings.first?.typeAnnotation?.type
    }
}

extension VariableDeclSyntax {
    /**
     * 初期値の値を取得する
     * var name: String = "HOGE" → "HOGE"
     * var name: String = nil
     */
    var initialValueString: String? {
        guard
            let binding = bindings.first,
            let initializer = binding.initializer
        else {
            return nil
        }

        return initializer
            .value
            .description
            .trimmingCharacters(in: .whitespaces)
    }

    /**
     * stored propertyかどうかを判定する(※ property wrapperなどの特殊系は判定できない)
     *  var name: String { "HOGE" } → true
     *  var name: String = "HOGE" → false
     */
    var isStoredProperty: Bool {
        // bindingsの要素がない場合はfalse
        if bindings.count != 1 {
            return false
        }

        let binding = bindings.first!

        // AccessorBlockSyntaxのAccessorを判定
        switch binding.accessorBlock?.accessors {
        case .none:
            return true

        case let .accessors(node):
            for accessor in node {
                switch accessor.accessorSpecifier.tokenKind {
                case .keyword(.willSet), .keyword(.didSet):
                    // willSet, didSetはstored propertyとなる
                    break

                default:
                    // 他の場合はcomputed propertyとなる
                    return false
                }
            }

            return true

        case .getter:
            return false
        }
    }
}
