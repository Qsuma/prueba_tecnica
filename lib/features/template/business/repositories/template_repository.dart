import 'package:dartz/dartz.dart';
import 'package:prueba_tecnica/core/error/failure.dart';

import '../entities/template_entity.dart';


abstract class TemplateRepository {
  Future<Either<Failure, TemplateEntity>> getTemplate();
}
