import '../../domain/entities/account.entity.dart';

class RemoteAccountModel{
  final String accessToken;
  RemoteAccountModel(this.accessToken);

  factory RemoteAccountModel.fromJson(Map<String, dynamic> json){
    return RemoteAccountModel(json['accessToken']);
  }

  AccountEntity get toEntity => AccountEntity(accessToken);
}