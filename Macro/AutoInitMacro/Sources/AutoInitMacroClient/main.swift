import AutoInitMacro
import Foundation

@AutoInit
public struct User {
    @Init(label: "_") let name: String
    @Init(label: "foo", default: 20) let age: Int
    let hobby: Hobby

    @AutoInit
    public struct Hobby {
        @Init(default: 80) let count: Int
    }
}

print(
    User(
        "Sam",
        foo: 10,
        hobby: User.Hobby()
    )
)
