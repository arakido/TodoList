class TodoInfo{
  late String timer;
  late String content;
  late bool complete;

  TodoInfo({required this.timer, required this.content, this.complete = false});

  TodoInfo.fromJson(Map<String, dynamic> json){
    timer = json['timer'];
    content = json['content'];
    complete = json['complete'] ?? false;
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> json = {};
    json['timer'] = timer;
    json['content'] = content;
    json['complete'] = complete;
    return json;
  }
}