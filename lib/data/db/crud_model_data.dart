abstract class CrudModelData<T> {
  Future<Map<String, dynamic>> buscarById(int id);
  Future<Map<String, dynamic>> guardar(T modelo);
  Future<Map<String, dynamic>> modificar(T modelo);
  Future<Map<String, dynamic>> eliminar(int id);
  Future<Map<String, dynamic>> obtenerTodos();
}
