import BuilderMacro
import Foundation

@Builder
struct User {
    let name: String
    let age: Int
    let hobby: String?
}

let user = User.makeBuilder()
    .name("Y.K")
    .age(29)
    .hobby("soccer")

print(String(describing: user))
