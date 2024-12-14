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
