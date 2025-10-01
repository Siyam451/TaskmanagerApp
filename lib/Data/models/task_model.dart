class Taskmodel{
  final String id;
  final String title;
  final String description;
  final String status;
  final String email;
  final String createddate;

  Taskmodel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.email,
    required this.createddate,

});

  factory Taskmodel.fromJson(Map<String,dynamic>Jsondata){
    return Taskmodel(
        id: Jsondata['_id'],
        title: Jsondata['title'],
        description: Jsondata['description'],
        status: Jsondata['status'],
        email: Jsondata['email'],
        createddate: Jsondata['createdDate']
    );
  }
}