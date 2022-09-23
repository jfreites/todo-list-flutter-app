class Todo {
  int id;
  DateTime time = DateTime.now();
  String title;
  String content;
  String image;

  Todo(
      {this.id = 0, time, this.title = "", this.content = "", this.image = ""});
}
