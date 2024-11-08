class LanguageLinkEntity {
  String? self;

  LanguageLinkEntity({this.self});

  LanguageLinkEntity.fromJson(Map<String, dynamic> json) {
    self = json['self'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['self'] = self;
    return data;
  }
}
