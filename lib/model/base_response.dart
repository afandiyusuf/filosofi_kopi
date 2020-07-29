class BaseResponse{
  final bool success;
  final String msg;

  BaseResponse({this.success,this.msg});
  factory BaseResponse.fromJson(Map<String, dynamic> map){
    return BaseResponse(
        success: map['success'],
        msg: map['msg']
    );
  }
}