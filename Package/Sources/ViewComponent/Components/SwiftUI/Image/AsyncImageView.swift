import Foundation
import SwiftUI

public struct AsyncImageView: View {
    private let url: URL?
    private let successImage: (Image) -> Image
    private let failureImage: () -> Image
    private let placeholderImage: () -> Image

    public init(
        url: URL?,
        successImage: @escaping (Image) -> Image,
        failureImage: @escaping (() -> Image) = {
            .penguin.resizable()
        },
        placeholderImage: @escaping (() -> Image) = {
            .penguin.resizable()
        }
    ) {
        self.url = url
        self.successImage = successImage
        self.failureImage = failureImage
        self.placeholderImage = placeholderImage
    }

    public var body: some View {
        AsyncImage(
            url: url,
            transaction: .init(animation: .easeIn(duration: 0.6))
        ) { phase in
            switch phase {
            case .empty:
                ProgressView()

            case let .success(image):
                successImage(image)
                    .resizable()

            case .failure:
                failureImage()
                    .resizable()

            @unknown default:
                placeholderImage()
                    .resizable()
            }
        }
    }
}

#Preview {
    VStack(alignment: .center) {
        AsyncImageView(
            url: .init(string: "https://picsum.photos/150/150"),
            successImage: {
                $0
            }
        )
        .frame(width: 150, height: 150)

        AsyncImageView(
            url: .init(string: "https://picsum"),
            successImage: { $0 },
            failureImage: {
                .penguin.resizable()
            },
            placeholderImage: {
                .penguin.resizable()
            }
        )
        .frame(width: 150, height: 150)
    }
}
