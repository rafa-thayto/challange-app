import 'package:audit_center/models/auditoria_model.dart';
import 'package:audit_center/repositories/auditoria_database.dart';

class AuditoriaRepository {
  Future<List<AuditoriaModel>> findAllAsync() async {
    var db = Database();
    await db.createDatabase();

    var auditorias = <AuditoriaModel>[];

    if (db.created) {
      auditorias = <AuditoriaModel>[];
      auditorias.add(
        new AuditoriaModel(id: 1, data: DateTime.now(), itens: 3, isOk: false),
      );
      auditorias.add(
        new AuditoriaModel(id: 2, data: DateTime.now(), itens: 0, isOk: true),
      );
      auditorias.add(
        new AuditoriaModel(id: 3, data: DateTime.now(), itens: 0, isOk: true),
      );
      auditorias.add(
        new AuditoriaModel(id: 4, data: DateTime.now(), itens: 5, isOk: false),
      );
    }

    return new Future.value(auditorias);
  }
}
