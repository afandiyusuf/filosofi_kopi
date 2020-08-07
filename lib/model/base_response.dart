class BaseResponse{
  final bool success;
  final String msg;
  final LoginResponse data;

  BaseResponse({this.success,this.msg,this.data});
  factory BaseResponse.fromJsonSuccess(Map<String, dynamic> map){
    return BaseResponse(
        success: map['success'],
        msg: map['msg'],
        data: LoginResponse.fromJson(map['data'])
    );
  }
  factory BaseResponse.fromJsonFail(Map<String, dynamic> map){
    return BaseResponse(
        success: map['success'],
        msg: map['msg']
    );
  }
}
class LoginResponse{
  final String token;
  final String expidedAt;
  LoginResponse({this.token, this.expidedAt});
  factory LoginResponse.fromJson(Map<String, dynamic> map){
    return LoginResponse(
        token: map['token'],
        expidedAt: map['expired_at']
    );
  }

}