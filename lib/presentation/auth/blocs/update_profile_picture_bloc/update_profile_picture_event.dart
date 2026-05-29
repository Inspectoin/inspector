part of 'update_profile_picture_bloc.dart';

abstract class UpdateProfilePictureEvent extends Equatable {
  const UpdateProfilePictureEvent();

  @override
  List<Object> get props => [];
}

class UpdateProfilePictureRequested extends UpdateProfilePictureEvent {
  final String imagePath;

  const UpdateProfilePictureRequested({required this.imagePath});

  @override
  List<Object> get props => [imagePath];
}
