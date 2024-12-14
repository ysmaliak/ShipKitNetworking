import Foundation

/// A protocol defining the requirements for authentication handling
public protocol AuthenticationProvider: Sendable {
    /// Set of HTTP status codes that should trigger authentication recovery
    var authenticationErrorStatusCodes: Set<Int> { get }
    
    /// Authenticates a URL request by modifying it as needed (e.g., adding auth headers)
    /// - Parameter request: The request to authenticate
    /// - Throws: Any error that occurs during authentication
    func authenticate(_ request: inout URLRequest) async throws

    /// Attempts to recover from an authentication error, typically by refreshing the auth token
    /// - Parameters:
    ///   - response: The HTTP response that triggered the authentication failure
    ///   - data: The response data that might contain error details
    /// - Returns: True if recovery was successful and the request should be retried
    /// - Throws: Any error that occurs during recovery
    func attemptAuthenticationRecovery(for response: HTTPURLResponse, responseData: Data?) async throws -> Bool
}

/// A no-op authentication provider that performs no authentication
public struct NoAuthProvider: AuthenticationProvider {
    public init() {}

    public var authenticationErrorStatusCodes: Set<Int> = []

    public func authenticate(_: inout URLRequest) async throws {}

    public func attemptAuthenticationRecovery(for _: HTTPURLResponse, responseData _: Data?) async throws -> Bool {
        false
    }
}
