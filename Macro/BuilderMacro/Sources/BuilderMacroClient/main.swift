import BuilderMacro
import Foundation

@Builder
struct User {
    let name: String
    let age: Int
    let hobby: Hobby
    let sample: Sample

    @Builder
    struct Hobby {
        let count: Int
    }

    @Builder
    enum Sample {
        case test1
        case test2
    }
}

let user = User.makeTestBuilder()
    .name("Y.K")
    .age(29)
    .hobby(User.Hobby.makeTestBuilder().count(20).build())
    .sample(User.Sample.makeTestBuilder().value(.test2).build())
    .build()

print(String(describing: user))
