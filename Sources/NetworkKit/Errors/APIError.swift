import Foundation

/// Represents errors that can occur during API operations
public enum APIError: Error, LocalizedError {
    /// Indicates the response received was invalid or couldn't be parsed
    case invalidResponse

    /// Indicates an HTTP error occurred with associated response and data
    /// - response: The HTTP response containing status code and headers
    /// - data: Raw response data that might contain error details
    case httpError(response: HTTPURLResponse, data: Data)

    public var errorDescription: String? {
        switch self {
        case .invalidResponse:
            String(localized: "apiErrorInvalidResponseDescription")
        case .httpError:
            String(localized: "apiErrorHttpErrorDescription")
        }
    }

    public var failureReason: String? {
        switch self {
        case .invalidResponse:
            String(localized: "apiErrorInvalidResponseReason")
        case .httpError:
            String(localized: "apiErrorHttpErrorReason")
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .invalidResponse:
            String(localized: "apiErrorInvalidResponseSuggestion")
        case .httpError:
            String(localized: "apiErrorHttpErrorSuggestion")
        }
    }
}
