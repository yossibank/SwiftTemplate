import SwiftUI

struct NetworkHTTPMethodView: View {
    let httpMethod: String?

    private var color: Color {
        switch httpMethod {
        case "GET": .green
        case "POST": .blue
        case "PUT": .orange
        case "PATCH": .teal
        case "DELETE": .red
        default: .gray
        }
    }

    var body: some View {
        Text(httpMethod ?? "取得失敗")
            .font(.subheadline)
            .foregroundStyle(color)
    }
}

#Preview {
    VStack(spacing: 8) {
        NetworkHTTPMethodView(httpMethod: "GET")
        NetworkHTTPMethodView(httpMethod: "POST")
        NetworkHTTPMethodView(httpMethod: "PUT")
        NetworkHTTPMethodView(httpMethod: "PATCH")
        NetworkHTTPMethodView(httpMethod: "DELETE")
        NetworkHTTPMethodView(httpMethod: "UNKNOWN")
    }
}
