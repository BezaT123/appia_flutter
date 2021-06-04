import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

// TODO: createFactory and createToJson aren't working
@JsonSerializable(/* createFactory: true, createToJson: true */)
class User {
  final String username;
  final String id;

  User(this.username, this.id);

  Map<String, dynamic> toJson() {
    return _$UserToJson(this);
  }

  static User fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }
}
