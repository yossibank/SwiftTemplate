import AppExtension
import AppUI
import SwiftUI
import ViewComponent

public struct RakutenView: View {
    @Environment(\.isSearching) private var isSearching

    @State private var isShowToast = false
    @State private var viewModel: RakutenViewModelProtocol

    public init(viewModel: RakutenViewModelProtocol) {
        self._viewModel = .init(wrappedValue: viewModel)
    }

    public var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                ScrollView {
                    switch viewModel.outputs.viewState {
                    case .initial:
                        InitialView()
                            .frame(proxy: proxy)

                    case .initialLoading:
                        AppLoadingView()
                            .frame(proxy: proxy)

                    case .additionalLoading:
                        VStack {
                            ItemsView(
                                viewModel: viewModel,
                                items: viewModel.outputs.loadedItems
                            )

                            AppLoadingView(.circle)
                                .padding(.vertical, 16)
                                .frame(height: 80)
                        }

                    case let .initialError(appError):
                        AppErrorView(
                            message: String(describing: appError),
                            didTapReloadButton: {
                                Task { @MainActor in
                                    await viewModel.inputs.search(isInitial: true)
                                }
                            }
                        )
                        .frame(proxy: proxy)

                    case .additionalError:
                        ItemsView(
                            viewModel: viewModel,
                            items: viewModel.outputs.loadedItems
                        )
                        .onAppear {
                            isShowToast = true
                        }

                    case let .loaded(items):
                        if items.isEmpty {
                            AppNoResultView(title: "商品が見つかりませんでした")
                                .frame(proxy: proxy)
                        } else {
                            ItemsView(
                                viewModel: viewModel,
                                items: items
                            )
                        }
                    }
                }
                .searchable(
                    text: $viewModel.binding.parameter.keyword,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "商品検索"
                )
                .onSubmit(of: .search) {
                    Task {
                        await viewModel.inputs.search(isInitial: true)
                    }
                }
                .showToast(
                    isShown: $isShowToast,
                    toast: .error,
                    message: "追加読み込み失敗"
                )
            }
        }
    }

    private struct InitialView: View {
        var body: some View {
            VStack(spacing: 24) {
                Image.penguin
                    .resizable()
                    .frame(width: 80, height: 80)

                Text("商品を検索してください")
                    .bold()
            }
        }
    }

    private struct ItemsView: View {
        let viewModel: RakutenViewModelProtocol
        let items: [RakutenViewItem.Item]

        var body: some View {
            LazyVStack(spacing: 16) {
                ForEach(items, id: \.id) { item in
                    VStack(alignment: .center) {
                        HStack(alignment: .top, spacing: 12) {
                            AsyncImageView(
                                url: item.imageURL,
                                successImage: { image in
                                    image.resizable()
                                }
                            )
                            .frame(width: 120, height: 120)
                            .clipShape(RoundedRectangle(cornerRadius: 4))

                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.system(size: 16, weight: .bold))
                                    .lineLimit(4)

                                Spacer()

                                HStack(alignment: .bottom) {
                                    Spacer()

                                    Text(item.price)
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundStyle(.red)
                                }
                            }
                        }
                        .padding(.horizontal, 16)

                        Divider()
                    }
                    .onAppear {
                        Task {
                            guard item == viewModel.outputs.loadedItems.last else {
                                return
                            }

                            await viewModel.inputs.additionalLoading(item)
                        }
                    }
                }
            }
        }
    }
}
