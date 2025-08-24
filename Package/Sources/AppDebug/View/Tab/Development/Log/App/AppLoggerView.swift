import AppExtension
import AppFeature
import SwiftUI

struct AppLoggerView: View {
    @State private var nowDate = Date.now

    private let dateConverter = DateConverter(.jp)

    var entry: LoggerEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 4) {
                Image(systemName: "circle.fill")
                    .font(.caption2)
                    .foregroundColor(entry.category.color)

                Text(dateConverter.dateToString(entry.date, format: .mmddEHHmmssSSS))
                    .font(.caption2)
                    .foregroundStyle(.gray)
                    .lineLimit(1)
                    .frame(maxWidth: 128, alignment: .leading)

                Text(entry.category.title)
                    .font(.caption2)
                    .foregroundStyle(.white)
                    .padding(.vertical, 1)
                    .padding(.horizontal, 4)
                    .background(entry.category.color)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .lineLimit(1)

                Spacer()

                Text(dateConverter.timeDifference(nowDate, targetDate: entry.date))
                    .font(.caption2)
                    .foregroundStyle(.gray)
                    .lineLimit(1)
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                            Task { @MainActor in
                                nowDate = .now
                            }
                        }
                    }
            }

            switch entry.message {
            case let .text(text):
                Text(text)
                    .opacity(0.7)
                    .font(.caption)
                    .bold()
                    .lineLimit(5)

            case let .event(event):
                VStack(alignment: .leading) {
                    HStack {
                        Text("イベント名")
                            .opacity(0.7)
                            .font(.caption)
                            .bold()

                        Spacer()

                        Text("呼び出し回数: \(entry.eventCount)回")
                            .opacity(0.5)
                            .font(.caption)
                            .bold()
                    }

                    Text(event.name)
                        .opacity(0.5)
                        .font(.caption)
                        .bold()
                }

                if !event.parameters.isEmpty {
                    VStack(alignment: .leading) {
                        Text("パラメータ名")
                            .opacity(0.7)
                            .font(.caption)
                            .bold()

                        ForEach(event.parameters.keys.sorted(), id: \.self) { key in
                            if let value = event.parameters[key] {
                                Text("\(key): \(value)")
                                    .opacity(0.5)
                                    .font(.caption)
                                    .bold()
                            }
                        }
                    }
                }
            }
        }
    }
}

private extension Logger.Category {
    var color: Color {
        switch self {
        case .trace: .gray
        case .debug: .green
        case .info: .indigo
        case .notice: .orange
        case .warning: .yellow
        case .error: .red
        case .critical: .purple
        case .fault: .brown
        case .firebase: .mint
        }
    }
}

#Preview {
    AppLoggerView(
        entry: .init(
            date: .now,
            category: .debug,
            message: .text("DEBUG LOG"),
            eventCount: 1
        )
    )
    .padding()
}
