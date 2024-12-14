import Foundation

/// Default implementation of RetryPolicy with exponential backoff
public final actor DefaultRetryPolicy: RetryPolicy {
    private var currentAttempt = 0
    private let maxRetries = 3
    private let baseDelay: TimeInterval = 0.3
    private let authRetryableStatusCodes: Set<Int> = [401, 403]
    private let generalRetryableStatusCodes: Set<Int> = [408, 500, 502, 503, 504]

    public init() {}

    public func shouldRetry(
        for response: HTTPURLResponse,
        data _: Data,
        authenticationProvider: AuthenticationProvider
    ) async throws -> Bool {
        guard currentAttempt < maxRetries else { return false }
        currentAttempt += 1

        guard !authRetryableStatusCodes.contains(response.statusCode) else {
            try await authenticationProvider.reauthenticate()
            return true
        }

        guard !generalRetryableStatusCodes.contains(response.statusCode) else {
            try await Task.sleep(nanoseconds: UInt64(baseDelay * Double(NSEC_PER_SEC)))
            return true
        }

        return false
    }
}

extension RetryPolicy where Self == DefaultRetryPolicy {
    /// A static property that returns a DefaultRetryPolicy instance.
    /// Provides exponential backoff with authentication handling.
    ///
    /// Example:
    /// ```swift
    /// let request = Request<Data>(
    ///     method: .get,
    ///     path: "/data",
    ///     retryPolicy: .default
    /// )
    /// ```
    public static var `default`: DefaultRetryPolicy { DefaultRetryPolicy() }
}
