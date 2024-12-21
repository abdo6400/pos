abstract class CacheConsumer {
  Future get({required String key});
  Future save({
    required String key,
    required String value,
  });
  Future clearAll();
  Future clearValue({required String key});
}
