import 'dart:convert';
import 'package:prueba_tecnica/core/error/exceptions.dart';

import '../models/template_model.dart';

abstract class TemplateLocalDataSource {
  Future<void> cacheTemplate({required TemplateModel? templateToCache});
  Future<TemplateModel> getLastTemplate();
}

const cachedTemplate = 'CACHED_TEMPLATE';

class TemplateLocalDataSourceImpl implements TemplateLocalDataSource {


  TemplateLocalDataSourceImpl();

  @override
  Future<TemplateModel> getLastTemplate() {
    final jsonString = '';

    if (jsonString != null) {
      return Future.value(TemplateModel.fromJson(json: json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheTemplate({required TemplateModel? templateToCache}) async {
    if (templateToCache != null) {
    //insertar en bd
    } else {
      throw CacheException();
    }
  }
}
