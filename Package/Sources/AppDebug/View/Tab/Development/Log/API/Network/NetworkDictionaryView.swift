import AppExtension
import SwiftUI

struct NetworkDictionaryView: View {
    let dictionaries: [String: String?]

    private var dictionariesArray: [(key: String, value: String?)] {
        Array(dictionaries).sorted(by: { $0.key < $1.key })
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(dictionariesArray, id: \.key) { queryItem in
                VStack(alignment: .leading) {
                    Text("【\(queryItem.key)】")
                        .font(.caption2)
                        .bold()
                        .foregroundStyle(.black.opacity(0.6))

                    Text(queryItem.value.unwrapped)
                        .font(.caption2)
                        .bold()
                        .foregroundStyle(.gray)
                        .lineLimit(3)
                        .padding(.leading, 6)
                }
            }
        }
    }
}

#Preview {
    NetworkDictionaryView(
        dictionaries: [
            "applicationId": "1032211485929725116",
            "formatVersion": "2",
            "hits": "30",
            "keyword": "からあげ",
            "page": "1"
        ]
    )
}
