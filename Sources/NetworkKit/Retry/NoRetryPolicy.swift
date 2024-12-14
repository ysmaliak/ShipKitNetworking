import Foundation

/// A policy that never retries requests
public struct NoRetryPolicy: RetryPolicy {
    public init() {}

    public func shouldRetry(
        for _: HTTPURLResponse,
        data _: Data,
        authenticationProvider _: AuthenticationProvider
    ) async throws -> Bool { false }
}

extension RetryPolicy where Self == NoRetryPolicy {
    /// A static property that returns a NoRetryPolicy instance.
    /// Use when you want to explicitly disable retries.
    ///
    /// Example:
    /// ```swift
    /// let request = Request<Data>(
    ///     method: .get,
    ///     path: "/data",
    ///     retryPolicy: .none
    /// )
    /// ```
    public static var none: NoRetryPolicy { NoRetryPolicy() }
}
