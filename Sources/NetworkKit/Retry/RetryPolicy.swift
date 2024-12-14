import Foundation

/// Defines the retry behavior for network requests that fail.
public protocol RetryPolicy: Sendable {
    /// Determines if a retry should be attempted based on the error and attempt number
    func shouldRetry(for: HTTPURLResponse, data: Data, authenticationProvider: AuthenticationProvider) async throws -> Bool
}
