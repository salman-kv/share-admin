
abstract class RoomPropertyState {}

final class RoomPropertyBlocInitial extends RoomPropertyState {}
class FeatureAddedState extends RoomPropertyState{}
class FeatureDeletedState extends RoomPropertyState{}
class MultipleImageAddedState extends RoomPropertyState{}
class NumberOfBedSelectedState extends RoomPropertyState{}
class RoomDeatailsSubmittingLoadingState extends RoomPropertyState{}
class RoomDeatailsSubmittedState extends RoomPropertyState{}
class RoomNumberTypingState extends RoomPropertyState{}
class RoomNumberSuccessState extends RoomPropertyState{}
class RoomNumberFailedState extends RoomPropertyState{}
class FeatureAlreadyExistState extends RoomPropertyState{}
