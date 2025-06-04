class AddAttendanceStates {}

class InitialState extends AddAttendanceStates {}

class OnLoading extends AddAttendanceStates {}

class OnSuccess extends AddAttendanceStates {}

class OnError extends AddAttendanceStates {
  final String message;
  OnError(this.message);
}

class OnAddAttendance extends AddAttendanceStates {}

class OnUpdateAttendance extends AddAttendanceStates {}

class OnSaveAttendance extends AddAttendanceStates {}

class OnDeleteAttendance extends AddAttendanceStates {}

class OnSelectDate extends AddAttendanceStates{}

class OnRest extends AddAttendanceStates{}

class OnGetMembers extends AddAttendanceStates{}

class OnGetServants extends AddAttendanceStates{}