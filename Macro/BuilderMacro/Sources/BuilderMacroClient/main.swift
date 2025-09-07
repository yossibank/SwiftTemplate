import BuilderMacro
import Foundation

@Builder
struct User {
    let name: String
    let age: Int
    let hobby: Hobby

    @Builder
    struct Hobby {
        let count: Int
    }
}

let user = User.makeTestBuilder()
    .name("Y.K")
    .age(29)
    .hobby(User.Hobby.makeTestBuilder().count(20).build())
    .build()

print(String(describing: user))
