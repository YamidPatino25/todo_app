import 'package:f_202010_todo_class/model/todo.dart';
import 'package:flutter/material.dart';
import 'package:f_202010_todo_class/pages/todo_type_dropdown.dart';

class HomePageTodo extends StatefulWidget {
  @override
  _HomePageTodoState createState() => _HomePageTodoState();
}

class _HomePageTodoState extends State<HomePageTodo> {
  List<Todo> todos = new List<Todo>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App"),
      ),
      body: _list(),
      floatingActionButton: new FloatingActionButton(
          onPressed: _addTodo, tooltip: 'Add task', child: new Icon(Icons.add)),
    );
  }

  Widget _list() {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, posicion) {
        var element = todos[posicion];
        //return _item(element, posicion);
        return Dismissible(
            //key: Key(element.toString()),
            key: UniqueKey(),
            background: _myHiddenContainer(),
            //child: _item(todos[posicion], posicion),
            child: Card(
              color:
                  element.completed == 1 ? Colors.blueGrey : Colors.yellow[200],
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(todos[posicion].title),
                    subtitle: Text(todos[posicion].body),                  
                    isThreeLine: true,
                    leading: _itemIcon(element),
                    onTap: () => _onTap(context, posicion),
                  ),
                ],
              ),
            ),
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) {
              todos.removeAt(posicion);
              if (posicion == 1) {}
              Scaffold.of(context).showSnackBar(new SnackBar(
                content: new Text("TODO deleted"),
              ));
            },
            
            
            );
      },
    );
  }
  Widget _itemIcon(Todo item){
    
    switch(item.type){
      case 'DEFAULT': 
      return Icon(Icons.schedule, size:70.0);
      case 'LIST': 
      return Icon(Icons.check, size:70.0);
      case 'HOME_WORK': 
      return Icon(Icons.home, size:70.0);
      default:
      return Icon(Icons.schedule, size:70.0);
    }
  } 



  void _onTap(BuildContext context, int posicion) {
    setState(() {
      if (this.todos[posicion].completed == 0) {
        this.todos[posicion].completed = 1;
      } else {
        this.todos[posicion].completed = 0;
      }
    });
  }

  Widget _myHiddenContainer() {
    return Container(
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "    Deleting...",
            style: TextStyle(color: Colors.white, fontSize: 15.0),
          ),
        ],
      ),
    );
  }

  void _addTodo() async {
    final todo = await showDialog<Todo>(
      context: context,
      builder: (BuildContext context) {
        return NewTodoDialog();
      },
    );

    if (todo != null) {
      setState(() {
        todos.add(todo);
      });
    }
  }

/*
  //Esto NO esta haciendo nada
  Widget _item(Todo element, int posicion) {
    //return Text('$posicion');
    return Column(
      children: <Widget>[
        Text(element.title),
        Text(element.body),
      ],
    );
  }
  */
}

class NewTodoDialog extends StatefulWidget {
  @override
  _NewTodoDialogState createState() => _NewTodoDialogState();
}

class _NewTodoDialogState extends State<NewTodoDialog> {
  final controllerTitle = new TextEditingController();
  final controllerBody = new TextEditingController();
  String _dropselected = 'DEFAULT';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[200],
      title: Text(
        'New todo',
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: controllerTitle,
            decoration: InputDecoration(
              labelText: 'Title',
              labelStyle: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Text(""),
          TextField(
            controller: controllerBody,
            decoration: InputDecoration(
              labelText: 'Body',
              labelStyle: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Expanded(
            child: TodoTypeDropdown(
              selected: _dropselected,
              onChangeValue:(value)=> setState((){
                _dropselected = value;
              }),
              ),
          ),
        ],
      ),
      actions: <Widget>[
        MaterialButton(
          child: Text(
            "Cancel",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        MaterialButton(
          child: Text(
            "Add",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          elevation: 5.0,
          onPressed: () {
            final todo = new Todo(
              title: controllerTitle.text,
              body: controllerBody.text,
              completed: 0,
              type: _dropselected,
            );

            controllerTitle.clear();
            controllerBody.clear();
            Navigator.of(context).pop(todo);
          },
        ),
      ],
    );
  }
}


