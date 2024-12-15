import Foundation

/// A protocol defining the requirements for authentication handling
public protocol AuthenticationProvider: Sendable {
    /// Authenticates a URL request by modifying it as needed (e.g., adding auth headers)
    /// - Parameter request: The request to authenticate
    /// - Throws: Any error that occurs during authentication
    func authenticate(_ request: inout URLRequest) async throws

    /// Attempts to recover from an authentication error (e.g. updating expired tokens)
    /// - Throws: Any error that occurs during re-authentication
    func reauthenticate() async throws
}

/// A no-op authentication provider that performs no authentication
public struct NoAuthProvider: AuthenticationProvider {
    public init() {}

    public func authenticate(_: inout URLRequest) async throws {}

    public func reauthenticate() async throws {}
}

extension AuthenticationProvider where Self == NoAuthProvider {
    /// A static property that returns a NoAuthProvider instance.
    /// Allows for more concise syntax when specifying no authentication is needed.
    ///
    /// Example:
    /// ```swift
    /// let request = Request<Data>(
    ///     method: .get,
    ///     path: "/public/data",
    ///     authenticationProvider: .none
    /// )
    /// ```
    public static var none: NoAuthProvider { NoAuthProvider() }
}
