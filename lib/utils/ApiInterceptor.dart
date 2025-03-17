import 'package:dio/dio.dart';

class ApiInterceptor {
  static Dio createDio() {
    final Dio dio = Dio();

    // Add custom interceptors for manual logs
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print("Request Method: ${options.method}");
        print("Request URL: ${options.uri}");
        print("Request Headers: ${options.headers}");
        print("Request Body: ${options.data}");
        handler.next(options);
      },
      onResponse: (response, handler) {
        print("Response Status Code: ${response.statusCode}");
        print("Response Data: ${response.data}");
        handler.next(response);
      },
      onError: (DioError error, handler) {
        print("Error Message: ${error.message}");
        if (error.response != null) {
          print("Error Response Data: ${error.response?.data}");
        }
        handler.next(error);
      },
    ));

    // Add the built-in LogInterceptor for extended logs
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,  // Logs the request body
      requestHeader: true, // Logs the request headers
      responseHeader: false, // Skip response headers
      responseBody: true,   // Logs the response body
      error: true,          // Logs error messages
      logPrint: (log) {
        final String logString = log.toString(); // Ensure the log is treated as a String
        if (logString.length > 1000) {
          // Break long logs into chunks
          final chunks = _splitIntoChunks(logString, 1000);
          for (final chunk in chunks) {
            print(chunk);
          }
        } else {
          print(logString);
        }
      },
    ));

    return dio;
  }

  // Helper function to split long strings into chunks
  static List<String> _splitIntoChunks(String text, int chunkSize) {
    final List<String> chunks = [];
    for (var i = 0; i < text.length; i += chunkSize) {
      chunks.add(text.substring(i, i + chunkSize > text.length ? text.length : i + chunkSize));
    }
    return chunks;
  }
}
