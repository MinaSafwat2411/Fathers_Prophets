class AttendanceStates {}

class InitialState extends AttendanceStates {}

class OnLoading extends AttendanceStates {}

class OnSuccess extends AttendanceStates {}

class OnError extends AttendanceStates {
  final String message;
  OnError(this.message);
}

class OnAddAttendance extends AttendanceStates {}

class OnUpdateAttendance extends AttendanceStates {}

class OnSaveAttendance extends AttendanceStates {}

class OnDeleteAttendance extends AttendanceStates {}

class OnSelectDate extends AttendanceStates{}

class OnRest extends AttendanceStates{}

class OnGetMembers extends AttendanceStates{}

class OnGetServants extends AttendanceStates{}

class OnDeleteAttendanceItem extends AttendanceStates{}


