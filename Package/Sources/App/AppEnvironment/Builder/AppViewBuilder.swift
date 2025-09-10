import Rakuten
import RakutenDetailView
import RakutenView
import SwiftUI
import ViewEnvironment

@MainActor
public enum AppViewBuilder {
    public static func build(
        with descriptor: ViewDescriptor.RakutenDescriptor,
        environment: any ViewEnvironment
    ) -> ViewDescriptor.RakutenDescriptor.Output {
        AnyView(
            RakutenView(
                viewModel: AppViewModelBuilder.rakuten(environment)
            )
        )
    }

    public static func build(
        with descriptor: ViewDescriptor.RakutenDetailDescriptor,
        environment: any ViewEnvironment
    ) -> ViewDescriptor.RakutenDescriptor.Output {
        AnyView(
            RakutenDetailView(
                title: descriptor.title
            )
        )
    }
}
