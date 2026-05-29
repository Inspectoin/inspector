import 'package:equatable/equatable.dart';

class ActivityLog  extends Equatable {
  String? username;
  int? createdAt;
  String? description;
  String? level;
  String? action;

  ActivityLog({
    this.username,
    this.createdAt,
    this.description,
    this.level,
    this.action,
});

  @override
  List<Object?> get props => [username,createdAt,description,level];

}
