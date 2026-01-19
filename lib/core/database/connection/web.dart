import 'package:drift/web.dart';

QueryExecutor connect() {
  return WebDatabase('focus_quest_db', logStatements: true);
}
