import '../../business/entities/template_entity.dart';

class TemplateModel extends TemplateEntity {
  const TemplateModel({required super.template});

  factory TemplateModel.fromJson({required Map<String, dynamic> json}) {
    return TemplateModel(template: json['']);
  }

  Map<String, dynamic> toJson() {
    return {'': template};
  }
}
