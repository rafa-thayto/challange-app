import 'package:audit_center/models/auditoria_model.dart';
import 'package:audit_center/repositories/auditoria_repository.dart';
import 'package:flutter/material.dart';

class AuditoriasScreen extends StatefulWidget {
  const AuditoriasScreen({Key? key}) : super(key: key);

  @override
  _AuditoriasScreenState createState() => _AuditoriasScreenState();
}

class _AuditoriasScreenState extends State<AuditoriasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<AuditoriaModel>>(
        future: AuditoriaRepository().findAllAsync(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return buildListView(snapshot.data);
          } else {
            return Center(
              child: RefreshProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  ListView buildListView(List<AuditoriaModel>? auditorias) {
    return ListView.builder(
        itemCount: auditorias == null ? 0 : auditorias.length,
        itemBuilder: (BuildContext ctx, int index) {
          return cardAuditoria(auditorias![index]);
        });
  }

  Card cardAuditoria(AuditoriaModel auditoria) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 12,
      margin: new EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      child: Column(
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: Colors.white70,
            ),
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              leading: Container(
                  padding: EdgeInsets.only(right: 12),
                  decoration: new BoxDecoration(
                    border: new Border(
                      right: new BorderSide(
                        width: 1,
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          child: Text('Data Auditoria: ${auditoria.data}'),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                              'Status Auditoria: ${auditoria.isOk ? 'OK' : 'NOK'}'),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Itens com problemas: ${auditoria.itens}',
                        ),
                      )
                    ],
                  )),
              title: Text(
                auditoria.id.toString(),
                style: TextStyle(
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Icon(
                Icons.favorite_outline_sharp,
                color: Colors.indigo,
                size: 30.0,
              ),
              onTap: () async {
                var messageReturn = await Navigator.pushNamed(
                  context,
                  '/auditoria_details',
                  arguments: auditoria,
                );
                print(messageReturn);
                // print(house.nome);
                //Navigator.push(...,arguments:house);
              },
            ),
          ),
        ],
      ),
    );
  }
}
