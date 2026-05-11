import 'dart:math';

/// Retry service with exponential backoff
/// 
/// Retry schedule:
/// - Attempt 1: Immediate
/// - Attempt 2: After 1 second
/// - Attempt 3: After 2 seconds
/// - Attempt 4: After 4 seconds
/// - Attempt 5: After 8 seconds
/// - Attempt 6+: Give up
class RetryService {
  static const int maxRetries = 5;
  static const double backoffMultiplier = 2.0;
  static const int initialDelaySeconds = 1;
  static const int maxDelaySeconds = 60;

  /// Determine if should retry based on attempt count
  bool shouldRetry(int retryCount) {
    return retryCount < maxRetries;
  }

  /// Calculate delay until next retry (with jitter)
  Duration getNextRetryDelay(int retryCount) {
    if (retryCount >= maxRetries) {
      return Duration.zero;
    }

    // Exponential backoff: 1s, 2s, 4s, 8s, etc.
    final exponentialDelay = initialDelaySeconds *
        pow(backoffMultiplier, retryCount).toInt();

    // Cap at max delay
    final cappedDelay = min(exponentialDelay, maxDelaySeconds);

    // Add random jitter (±20%) to prevent thundering herd
    final jitter = (cappedDelay * 0.2 * (Random().nextDouble() * 2 - 1))
        .toInt();
    final finalDelay = max(1, cappedDelay + jitter);

    return Duration(seconds: finalDelay);
  }

  /// Get total wait time for all retries (for diagnostics)
  Duration getTotalWaitTime() {
    int total = 0;
    for (int i = 0; i < maxRetries; i++) {
      total += getNextRetryDelay(i).inSeconds;
    }
    return Duration(seconds: total);
  }
}
