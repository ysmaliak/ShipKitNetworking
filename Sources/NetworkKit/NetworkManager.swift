import Foundation

/// The main entry point for NetworkKit configuration and setup.
/// Provides methods to configure the network stack with default or custom settings.
public actor NetworkManager {
    /// The global configuration settings for NetworkKit.
    /// This property stores the current configuration used for all network requests.
    public static var configuration = Configuration()

    /// Configures NetworkKit with default settings.
    /// Default settings include:
    /// - No base URL
    /// - Default URL session configuration
    /// - ISO8601 JSON decoder/encoder
    /// - Shared URL cache
    public static func configure() {
        configuration = Configuration()
    }

    /// Configures NetworkKit with custom settings.
    /// - Parameter configuration: A custom Configuration instance that defines network behavior, including base URL, encoders, decoders,
    /// and caching settings.
    public static func configure(with configuration: Configuration) {
        self.configuration = configuration
    }

    /// Configures NetworkKit with individual custom settings.
    /// - Parameters:
    ///   - baseURL: The base URL to be prepended to all network requests. Defaults to nil.
    ///   - urlSessionConfiguration: The URL session configuration to be used for all network requests. Defaults to the default
    /// configuration.
    ///   - decoder: The JSON decoder used for response parsing. Defaults to ISO8601-configured decoder.
    ///   - encoder: The JSON encoder used for request serialization. Defaults to ISO8601-configured encoder.
    ///   - cache: The URL cache for storing responses. Defaults to the shared system cache.
    public static func configure(
        baseURL: URL? = nil,
        urlSessionConfiguration: URLSessionConfiguration = .default,
        decoder: JSONDecoder = .iso8601,
        encoder: JSONEncoder = .iso8601,
        cache: URLCache = .shared
    ) {
        configuration = Configuration(
            baseURL: baseURL,
            urlSessionConfiguration: urlSessionConfiguration,
            decoder: decoder,
            encoder: encoder,
            cache: cache
        )
    }
}
