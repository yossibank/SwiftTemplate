import Foundation

/// コンパイル時にURL文字列を検証し、有効なURLを生成
///
/// 使用例:
/// ```swift
/// let apiURL = #URL("https://api.example.com/users")
/// let websiteURL = #URL("https://www.example.com")
/// ```
///
/// - Parameter urlString: 有効なHTTP/HTTPS URLを表す文字列リテラル
/// - Returns: UR"Lオブジェクト
///
/// エラー条件:
/// - 引数が不足している場合
/// - 引数が文字列でない場合
/// - 無効なURL形式の場合
/// - スキームがhttp/https以外の場合
/// - ホストが空または存在しない場合
@freestanding(expression)
public macro URL(_ urlString: String) -> URL = #externalMacro(
    module: "URLMacroMacros",
    type: "URLMacro"
)
