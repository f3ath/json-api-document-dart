import 'package:json_api_document/json_api_document.dart';

class JsonApiValidator {
  List<ValidationError> dataErrors(PrimaryData data) {
    final errors = <ValidationError>[];

    final included = Set<String>();

    errors.addAll(data.included
        .map((_) => _.toResource().toIdentifier().toString())
        .where((_) => !included.add(_))
        .map((_) => ValidationError('Resource $_ is included multiple times')));

    if (data is ResourceData) {
      final id = data.toResource().toIdentifier();
      if (data.included.any((_) => _.toResource().toIdentifier().equals(id))) {
        errors.add(ValidationError('Primary resource ${id} is also included'));
      }
    }
    return errors;
  }
}

class ValidationError {
  final String message;

  ValidationError(this.message);
}
