# Test task

Тестове завдання Webspark: Flutter-застосунок, який отримує з API набір сіток, знаходить на кожній найкоротший шлях від старту до фінішу та відправляє результати назад на сервер.

## Стек

- Flutter 3.35 / Dart 3.9
- `flutter_bloc` — керування станом (Cubit для екрану url, Bloc для процесу розрахунку)
- `get_it` — впровадження залежностей
- `http` — REST API
- `shared_preferences` — збереження введеного url
- `bloc_test`, `mocktail` — тести

## Тести

- `flutter test` — unit та bloc тести
- `flutter test integration_test -d <device>` — повний сценарій на реальному API
