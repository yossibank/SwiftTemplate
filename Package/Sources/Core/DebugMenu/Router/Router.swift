import SwiftUI

@Observable
final class Router: @unchecked Sendable {
    var path = [Route]()

    @MainActor
    @ViewBuilder
    func view(for route: Route) -> some View {
        switch route {
        case let .log(log):
            switch log {
            case .app:
                AppLoggerListView()

            case let .api(api):
                switch api {
                case .list:
                    APIResponseListView()

                case let .detail(model):
                    APIResponseDetailView(model: model)

                case let .body(model, mode):
                    APIResponseBodyView(model: model, mode: mode)
                }
            }
        }
    }

    func push(_ route: Route) {
        path.append(route)
    }

    func back() {
        path.removeLast()
    }

    func popToRoot() {
        path.removeLast(path.count)
    }
}

extension EnvironmentValues {
    var router: Router {
        get { self[RouterKey.self] }
        set { self[RouterKey.self] = newValue }
    }
}

private struct RouterKey: EnvironmentKey {
    static let defaultValue = Router()
}
