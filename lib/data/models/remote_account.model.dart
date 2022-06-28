import '../../domain/entities/account.entity.dart';
import '../../helpers/helpers.exports.dart';

class RemoteAccountModel{
  final String accessToken;
  RemoteAccountModel(this.accessToken);

  factory RemoteAccountModel.fromJson(Map<String, dynamic> json){
    if(!json.containsKey("accessTokey")){
      throw HttpError.invalidData;
    }
    return RemoteAccountModel(json['accessToken']);
  }

  AccountEntity get toEntity => AccountEntity(accessToken);
}