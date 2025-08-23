public enum ViewModelState<T: Equatable>: Equatable {
    case initial
    case loading
    case error
    case loaded(T)
}
