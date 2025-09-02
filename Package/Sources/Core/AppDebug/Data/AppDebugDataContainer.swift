import AppConfiguration
import Foundation
import SwiftData

@MainActor
public enum AppDebugDataContainer {
    public static let container: ModelContainer = {
        let schema = Schema([
            APIModel.self
        ])

        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: true
        )

        do {
            return try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
        } catch {
            fatalError(error.localizedDescription)
        }
    }()

    public static func interceptor(_ item: APIModelItem) async {
        guard AppConfiguration.Build.isLogging else {
            return
        }

        let model = APIModel(item: item)
        let context = container.mainContext
        let maxEntries = 200

        context.insert(model)

        let fetchRequest = FetchDescriptor<APIModel>(
            sortBy: [.init(\.date, order: .forward)]
        )

        do {
            let allModels = try context.fetch(fetchRequest)

            if allModels.count > maxEntries {
                for model in allModels.prefix(1) {
                    context.delete(model)
                }
            }

            try context.save()
        } catch {}
    }
}

// MARK: - preview

extension AppDebugDataContainer {
    static let previewContainer: ModelContainer = {
        for i in 1...5 {
            container.mainContext.insert(
                APIModel(
                    date: Date().addingTimeInterval(-Double(i * 20)),
                    host: "app.rakuten.co.jp",
                    path: "/services/api/IchibaItem/Search/20220601/\(i)",
                    requestHeaders: ["Content-Type": "application/json"],
                    responseHeaders: ["Content-Type": "application/json"],
                    errorDescription: nil,
                    errorLocalizedDescription: nil,
                    httpMethod: {
                        switch i {
                        case 1: "GET"
                        case 2: "POST"
                        case 3: "PUT"
                        case 4: "PATCH"
                        case 5: "DELETE"
                        default: "UNKNOWN"
                        }
                    }(),
                    httpBody: """
                    {"userId":1,"id":1,"title":"sunt aut facere repellat provident occaecati excepturi optio reprehenderit"}
                    """,
                    responseBody: """
                    {"userId": 1,"id": 1,"title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit"}
                    """,
                    responseSize: "100KB",
                    queryItems: i % 2 == 0 ? [:] : [
                        "applicationId": "1032211485929725116",
                        "formatVersion": "2",
                        "hits": "30",
                        "keyword": "からあげ",
                        "page": "1"
                    ],
                    statusCode: i * 100
                )
            )
        }

        return container
    }()
}
