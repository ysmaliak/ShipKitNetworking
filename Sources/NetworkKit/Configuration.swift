import Foundation

/// Configuration settings for the NetworkKit client.
///
/// This struct encapsulates all configuration options needed to customize the behavior
/// of network requests, including URL configuration, session settings, and data encoding/decoding.
///
/// Example usage:
/// ```swift
/// var config = NetworkKit.Configuration()
/// config.baseURL = URL(string: "https://api.example.com")
/// config.decoder = .iso8601
///
/// NetworkKit.configure(with: config)
/// ```
public struct Configuration: Sendable {
    /// The base URL for all network requests.
    ///
    /// This URL will be used as the prefix for all relative paths in requests.
    /// If not set, requests must use absolute URLs.
    ///
    /// Example: "https://api.example.com"
    public var baseURL: URL?

    /// The retry policy for failed network requests.
    ///
    /// Specifies how many times a request should be retried and under what conditions.
    /// The default policy (`.default`) provides:
    /// - Maximum of 3 retry attempts
    /// - Authentication retries (401, 403): Triggers reauthentication immediately
    /// - General retries (408, 500, 502, 503, 504): Uses exponential backoff starting at 0.3 seconds
    ///
    /// Example:
    /// ```swift
    /// var config = Configuration()
    /// config.retryPolicy = .default // Uses DefaultRetryPolicy
    /// ```
    public var retryPolicy: RetryPolicy

    /// The authentication provider for network requests.
    ///
    /// Handles authentication token management and injection into requests.
    /// Defaults to no authentication.
    public var authProvider: AuthenticationProvider

    /// Configuration for the URLSession used to make network requests.
    ///
    /// This allows customization of session-wide settings such as:
    /// - Timeout values
    /// - Maximum connection count
    /// - TLS settings
    /// - Cookie policies
    /// - Proxy settings
    public var urlSessionConfiguration: URLSessionConfiguration

    /// The JSON decoder used to parse response data.
    ///
    /// Defaults to a decoder configured for ISO8601 date formatting.
    /// Can be customized to handle different date formats or decoding strategies.
    public var decoder: JSONDecoder

    /// The JSON encoder used to serialize request data.
    ///
    /// Defaults to an encoder configured for ISO8601 date formatting.
    /// Can be customized to handle different date formats or encoding strategies.
    public var encoder: JSONEncoder

    /// The URL cache used for storing and retrieving cached responses.
    ///
    /// Controls how responses are cached and when cached responses are used.
    /// Defaults to the shared system cache.
    public var cache: URLCache

    /// The cache policy for network requests.
    ///
    /// Controls how responses are cached and when cached responses are used.
    /// Defaults to `.reloadIgnoringLocalAndRemoteCacheData`.
    public var cachePolicy: URLRequest.CachePolicy

    /// The timeout interval for network requests.
    ///
    /// Defaults to 30 seconds.
    public var timeoutInterval: TimeInterval

    /// Creates a new API configuration with the specified settings.
    ///
    /// - Parameters:
    ///   - baseURL: The base URL for all network requests.
    ///   - urlSessionConfiguration: The URL session configuration.
    ///   - decoder: The JSON decoder.
    ///   - encoder: The JSON encoder.
    ///   - cache: The URL cache.
    public init(
        baseURL: URL? = nil,
        retryPolicy: RetryPolicy = .default,
        authProvider: AuthenticationProvider = .none,
        urlSessionConfiguration: URLSessionConfiguration = .default,
        decoder: JSONDecoder = .iso8601,
        encoder: JSONEncoder = .iso8601,
        cache: URLCache = .shared,
        cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData,
        timeoutInterval: TimeInterval = 30
    ) {
        self.baseURL = baseURL
        self.retryPolicy = retryPolicy
        self.authProvider = authProvider
        self.urlSessionConfiguration = urlSessionConfiguration
        self.decoder = decoder
        self.encoder = encoder
        self.cache = cache
        self.cachePolicy = cachePolicy
        self.timeoutInterval = timeoutInterval
    }
}
