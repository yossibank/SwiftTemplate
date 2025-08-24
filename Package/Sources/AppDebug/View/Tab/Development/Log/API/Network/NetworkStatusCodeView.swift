import SwiftUI

struct NetworkStatusCodeView: View {
    let statusCode: Int

    private var title: String {
        let title = switch statusCode {
        case 100: "Continue"
        case 101: "Switching Protocols"
        case 200: "OK"
        case 201: "Created"
        case 202: "Accepted"
        case 203: "Non-Authoritative Information"
        case 204: "No Content"
        case 205: "Reset Content"
        case 206: "Partial Content"
        case 300: "Multiple Choices"
        case 301: "Moved Permanently"
        case 302: "Found"
        case 303: "See Other"
        case 304: "Not Modified"
        case 305: "Use Proxy"
        case 400: "Bad Request"
        case 401: "Unauthorized"
        case 402: "Payment Required"
        case 403: "Forbidden"
        case 404: "Not Found"
        case 405: "Method Not Allowed"
        case 406: "Not Acceptable"
        case 407: "Proxy Authentication Required"
        case 408: "Request Time-out"
        case 409: "Conflict"
        case 410: "Gone"
        case 411: "Length Required"
        case 412: "Precondition Failed"
        case 413: "Request Entity Too Large"
        case 414: "Request-URI Too Large"
        case 415: "Unsupported Media Type"
        case 429: "Too Many Requests"
        case 500: "Internal Server Error"
        case 501: "Not Implemented"
        case 502: "Bad Gateway"
        case 503: "Service Unavailable"
        case 504: "Gateway Time-out"
        case 505: "HTTP Version not supported"
        case 0: "エラー"
        default: "Unknown"
        }

        return statusCode == 0
            ? title
            : "\(statusCode) \(title)"
    }

    private var color: Color {
        switch statusCode {
        case 100...101: .teal
        case 200...206: .green
        case 300...305: .indigo
        case 400...415, 429: .orange
        case 500...504: .pink
        case 0: .red
        default: .gray
        }
    }

    var body: some View {
        Text(title)
            .font(.caption2)
            .foregroundStyle(.white)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .lineLimit(1)
    }
}

#Preview {
    VStack(spacing: 8) {
        NetworkStatusCodeView(statusCode: 100)
        NetworkStatusCodeView(statusCode: 200)
        NetworkStatusCodeView(statusCode: 300)
        NetworkStatusCodeView(statusCode: 400)
        NetworkStatusCodeView(statusCode: 500)
        NetworkStatusCodeView(statusCode: 999)
        NetworkStatusCodeView(statusCode: 0)
    }
}
