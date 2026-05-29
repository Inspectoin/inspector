

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<bool>  get onChange;
}
