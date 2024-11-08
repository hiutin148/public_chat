class LanguageMetaEntity {
  int? count;

  LanguageMetaEntity({this.count});

  LanguageMetaEntity.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    return data;
  }
}
