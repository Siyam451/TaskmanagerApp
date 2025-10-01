class URLS{
  static const String _baseurl = 'http://35.73.30.144:2005/api/v1';
  static const String registrationurl = '$_baseurl/Registration';
  static const String loginurl = '$_baseurl/Login';
  static const String createtaskurl = '$_baseurl/createTask';
  static const String taskStatusCounturl = '$_baseurl/taskStatusCount';
  static const String NewtaskListurl = '$_baseurl/listTaskByStatus/New' ;
  static const String ProgresstaskListurl = '$_baseurl/listTaskByStatus/Progress';
  static  String Updatetaskstatusurl(String id, String status) => '$_baseurl/updateTaskStatus/$id/$status';
  static const String CompletetaskListurl = '$_baseurl/listTaskByStatus/Completed';
  static const String CanceledtaskListurl = '$_baseurl/listTaskByStatus/Canceled';
  static  String Deletetaskstatusurl(String id,) => '$_baseurl/deleteTask/$id';



}