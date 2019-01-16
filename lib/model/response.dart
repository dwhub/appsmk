class Response {
  Response({this.code,
        this.message});
  
  final int code;
  final Object message;

  factory Response.fromJson(Map value) {
    return Response(
        code: value['code'],
        message: value['message']);
  }
}