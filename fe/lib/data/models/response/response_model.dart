class SuccessResponse<T> {
  final bool success;
  final int statusCode;
  final String message;
  final T data;

  SuccessResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory SuccessResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    // if (json['data'] == null) {
    //   throw ArgumentError('Missing required field: data');
    // }

    return SuccessResponse(
      success: json['success'] ?? true,
      statusCode: json['statusCode'] is int
          ? json['statusCode']
          : int.tryParse(json['statusCode'].toString()) ?? 0,
      message: json['message']?.toString() ?? '',
      data: fromJsonT(json['data']),
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      'success': success,
      'statusCode': statusCode,
      'message': message,
      'data': toJsonT(data),
    };
  }
}

class ErrorResponse {
  final bool success;
  final int statusCode;
  final String message;

  ErrorResponse({
    required this.success,
    required this.statusCode,
    required this.message,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    // if (json['statusCode'] == null) {
    //   throw ArgumentError('Missing required field: statusCode');
    // }

    return ErrorResponse(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] is int
          ? json['statusCode']
          : int.tryParse(json['statusCode'].toString()),
      message: json['message']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'statusCode': statusCode, 'message': message};
  }
}
