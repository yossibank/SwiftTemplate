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

            Text(entry.message)
                .opacity(0.7)
                .font(.caption)
                .bold()
                .lineLimit(5)
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
        }
    }
}

#Preview {
    AppLoggerView(
        entry: .init(
            date: .now,
            category: .debug,
            message: "DEBUG LOG"
        )
    )
    .padding()
}
