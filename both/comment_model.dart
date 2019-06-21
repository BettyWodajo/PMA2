class Comment {
  final String user_id;
  final String blog_id;

  final String text;




  


  Comment({
    this.blog_id,
    this.text,
    this.user_id


  });


  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      user_id: json['user_id'],
      blog_id: json['blog_id'],
      text: json['text'],
     



    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map['user_id'] = user_id;
    map["blog_id"] = blog_id;

    map['text'] = text;
  

    // map["body"] = body;

    return map;
  }
}