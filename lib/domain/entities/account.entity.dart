class AccountEntity{
  final String token;
  AccountEntity(this.token);

  factory AccountEntity.fromJson(Map<String, dynamic> json){
    return AccountEntity(json['accessToken']);
  }
}