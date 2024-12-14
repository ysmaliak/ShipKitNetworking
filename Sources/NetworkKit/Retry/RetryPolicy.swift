import Foundation

/// Defines the retry behavior for network requests that fail.
public protocol RetryPolicy: Sendable {
    /// Current number of retry attempts made
    var currentAttempt: Int { get set }
    
    /// Maximum number of retry attempts allowed
    var maxRetries: Int { get }
    
    /// Set of HTTP status codes that should trigger a retry
    var retryableStatusCodes: Set<Int> { get }
    
    /// Determines if a retry should be attempted based on the error and attempt number
    func shouldRetry(_ error: Error) -> Bool
    
    /// Calculates the delay duration before the next retry attempt
    func delay() -> TimeInterval
}

/// Default implementation of RetryPolicy with exponential backoff
public struct DefaultRetryPolicy: RetryPolicy {
    public var currentAttempt: Int
    public let maxRetries: Int
    public let retryableStatusCodes: Set<Int>
    
    private let baseDelay: TimeInterval
    private let multiplier: Double
    
    public init(
        maxRetries: Int = 3,
        baseDelay: TimeInterval = 0.3,
        multiplier: Double = 1.0,
        retryableStatusCodes: Set<Int> = [408, 500, 502, 503, 504]
    ) {
        self.currentAttempt = 0
        self.maxRetries = maxRetries
        self.baseDelay = baseDelay
        self.multiplier = multiplier
        self.retryableStatusCodes = retryableStatusCodes
    }
    
    public func shouldRetry(_ error: Error) -> Bool {
        guard currentAttempt < maxRetries else { return false }
        
        if let urlError = error as? URLError {
            switch urlError.code {
            case .timedOut, .networkConnectionLost:
                return true
            default:
                if let response = urlError.errorUserInfo[NSUnderlyingErrorKey] as? HTTPURLResponse {
                    return retryableStatusCodes.contains(response.statusCode)
                }
                return false
            }
        }
        return false
    }
    
    public func delay() -> TimeInterval {
        baseDelay * pow(multiplier, Double(currentAttempt))
    }
}

/// A policy that never retries requests
public struct NoRetryPolicy: RetryPolicy {
    public var currentAttempt: Int = 0
    public let maxRetries: Int = 0
    public let retryableStatusCodes: Set<Int> = []
    
    public init() {}
    
    public func shouldRetry(_: Error) -> Bool { false }
    public func delay() -> TimeInterval { 0 }
}
