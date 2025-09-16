import 'package:mobx/mobx.dart';
import 'package:todomobx/stores/todo_store.dart';
part 'list_store.g.dart';

class ListStore = _ListStoreBase with _$ListStore;

abstract class _ListStoreBase with Store {
  @observable
  String newTodoTitle = '';

  ObservableList<TodoStore> todoList = ObservableList<TodoStore>();

  @action
  void setNewTodoTitle(String value) => newTodoTitle = value;

  @action
  void addTodoTask(String value) {
    todoList.insert(0, TodoStore(value));
  }

  @computed
  bool get hasValidTextInput => newTodoTitle.isNotEmpty;
}
