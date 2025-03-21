import 'package:dartz/dartz.dart';
import 'package:prueba_tecnica/core/error/failure.dart';
import '../entities/template_entity.dart';
import '../repositories/template_repository.dart';

class GetTemplate {
  final TemplateRepository templateRepository;

  GetTemplate({required this.templateRepository});

  Future<Either<Failure, TemplateEntity>> call() async {
    return await templateRepository.getTemplate();
  }
}
