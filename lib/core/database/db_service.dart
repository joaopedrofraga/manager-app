import 'package:postgres/postgres.dart';

class DbService {
  static final DbService _singleton = DbService._internal();

  factory DbService() {
    return _singleton;
  }

  DbService._internal();

  Connection? _connection;

  Future<Connection> get connection async {
    if (_connection == null || !_connection!.isOpen) {
      await connect();
    }
    return _connection!;
  }

  Future<void> connect() async {
    try {
      _connection = await Connection.open(
        Endpoint(
          host: 'localhost',
          port: 5432,
          database: 'madb',
          username: 'postgres',
          password: '123456',
        ),
        settings: ConnectionSettings(sslMode: SslMode.disable),
      );
      print('✅ Conectado ao banco de dados com sucesso');
    } catch (e) {
      print('❌ Erro ao conectar: $e');
      throw Exception('Erro ao conectar ao banco de dados: $e');
    }
  }

  Future<void> close() async {
    if (_connection != null && _connection!.isOpen) {
      await _connection!.close();
      print('🔌 Conexão encerrada');
    }
  }
}
