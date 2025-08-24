import AppFeature
import SwiftUI
import ViewComponent

struct AppLoggerListView: View {
    @State private var entries = [LoggerEntry]()
    @State private var scope = Scope.all
    @State private var query = ""
    @State private var isLoading = false

    private var scopeEntries: [LoggerEntry] {
        let newEntries: [LoggerEntry] = switch scope {
        case .all: entries
        case let .category(category): entries.filter { $0.category == category }
        }

        let trimmedQuery = query.trimmingCharacters(in: .whitespaces)

        return trimmedQuery.isEmpty
            ? newEntries
            : newEntries.filter {
                let message = switch $0.message {
                case let .text(text): text
                case let .event(event): event.name
                }

                return message.range(
                    of: trimmedQuery,
                    options: [.caseInsensitive, .diacriticInsensitive, .widthInsensitive]
                ) != nil
            }
    }

    private let loggerStore = LoggerStore()

    private enum Scope: Hashable {
        case all
        case category(Logger.Category)
    }

    var body: some View {
        Group {
            if isLoading {
                AppLoadingView(.circle)
                    .frame(width: 60, height: 60)
            } else {
                VStack(alignment: .leading) {
                    Picker("カテゴリー", selection: $scope) {
                        Text("All")
                            .tag(Scope.all)

                        ForEach(Logger.Category.allCases, id: \.self) { category in
                            Text(category.title)
                                .tag(Scope.category(category))
                        }
                    }
                    .padding(.horizontal)

                    List(scopeEntries, id: \.date) { entry in
                        AppLoggerView(entry: entry)
                    }
                    .listStyle(.inset)
                }
                .searchable(text: $query)
            }
        }
        .task {
            isLoading = true

            defer {
                isLoading = false
            }

            do {
                entries = try await loggerStore.allEntries()
            } catch {}
        }
    }
}

#Preview {
    RouterView(router: Router()) {
        AppLoggerListView()
    }
}
