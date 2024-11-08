import 'language_entity.dart';
import 'language_link_entity.dart';
import 'language_meta_entity.dart';

class LanguageApiResponse {
  LanguageLinkEntity? links;
  LanguageMetaEntity? meta;
  List<LanguageEntity>? data;

  LanguageApiResponse({this.links, this.meta, this.data});

  LanguageApiResponse.fromJson(Map<String, dynamic> json) {
    links = json['links'] != null
        ? LanguageLinkEntity.fromJson(json['links'])
        : null;
    meta =
        json['meta'] != null ? LanguageMetaEntity.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <LanguageEntity>[];
      json['data'].forEach((v) {
        data!.add(LanguageEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (links != null) {
      data['links'] = links!.toJson();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
