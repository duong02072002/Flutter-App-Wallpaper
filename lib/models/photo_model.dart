// ignore_for_file: public_member_api_docs, sort_constructors_first
class PhotosModel {
  String? url;
  SrcModel? src;

  PhotosModel({
    this.url,
    this.src,
  });

  factory PhotosModel.fromMap(Map<String, dynamic> parsedJson) {
    return PhotosModel(
        url: parsedJson['url'],
        src: SrcModel.fromMap(
          parsedJson['src'],
        ));
  }
}

class SrcModel {
  String? landscape;
  String? large;
  String? medium;
  String? portrait;
  SrcModel({
    this.portrait,
    this.large,
    this.landscape,
    this.medium,
  });
  factory SrcModel.fromMap(Map<String, dynamic> srcJson) {
    return SrcModel(
      portrait: srcJson['portrait'],
      large: srcJson['large'],
      medium: srcJson['medium'],
      landscape: srcJson['landscape'],
    );
  }
}
