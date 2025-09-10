import AppFoundation
import Foundation

/// @mockable
@MainActor
public protocol RakutenViewModelProtocol: AnyObject {
    var inputs: RakutenViewInput { get }
    var outputs: RakutenViewOutput { get }
    var binding: RakutenViewBinding { get set }
    var router: RakutenRouter { get }
}

/// @mockable
@MainActor
public protocol RakutenViewBinding: AnyObject {
    var parameter: RakutenViewItem.Parameter { get set }
}

/// @mockable
@MainActor
public protocol RakutenViewInput: AnyObject {
    func search(isInitial: Bool) async
    func additionalLoading(_ item: RakutenViewItem.Item) async
}

/// @mockable
@MainActor
public protocol RakutenViewOutput: AnyObject {
    var viewState: AppPagingState<RakutenViewItem.Item> { get set }
    var loadedItems: [RakutenViewItem.Item] { get set }
}
