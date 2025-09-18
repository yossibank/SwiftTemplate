import AutoInitMacro
import Foundation

@AutoInit
struct User {
    @Init(label: "_") let name: String
    @Init(label: "foo") let age: Int
    let hobby: Hobby

    @AutoInit
    struct Hobby {
        let count: Int
    }
}

print(
    User(
        "Sam",
        foo: 10,
        hobby: User.Hobby(count: 10)
    )
)
