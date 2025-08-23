import Combine

public extension Publisher where Self.Failure == Never {
    func withUnretained<Owner: AnyObject>(
        _ owner: Owner
    ) -> Publishers.CompactMap<Self, (owner: Owner, output: Output)> {
        compactMap { [weak owner] output in
            guard let owner else {
                return nil
            }

            return (owner, output)
        }
    }
}
