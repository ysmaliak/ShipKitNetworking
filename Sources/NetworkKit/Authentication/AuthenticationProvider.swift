import Foundation

/// A protocol defining the requirements for authentication handling
public protocol AuthenticationProvider: Sendable {
    /// Authenticates a URL request by modifying it as needed (e.g., adding auth headers)
    /// - Parameter request: The request to authenticate
    /// - Throws: Any error that occurs during authentication
    func authenticate(_ request: inout URLRequest) async throws

    /// Attempts to recover from an authentication error
    func reauthenticate() async throws
}

/// A no-op authentication provider that performs no authentication
public struct NoAuthProvider: AuthenticationProvider {
    public init() {}

    public func authenticate(_: inout URLRequest) async throws {}

    public func reauthenticate() async throws {}
}
