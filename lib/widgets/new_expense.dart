import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/model/expense.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget{
  const NewExpense({super.key,required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense>{
  final _titleController = TextEditingController();//an object that can be paased as a value to textFiels , for storing entered value. we have to dispose it after use , otherwise t will stay in memmory.
  final _amountController = TextEditingController();
  DateTime? _selectedDate;//'?' tells that initially it wont have any value, it either has selected date or null value.
  Categorys _selectedCategory = Categorys.leisure;

  void _presentDatePicker() async{
    final now = DateTime.now();//initial date
    final firstDate = DateTime(now.year-1,now.month,now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now
    );
    setState(() {
      _selectedDate = pickedDate;
    });//this line will be executed only after value is available.
    //.then((value) {
   // },);
  }//showDAtePicker is a build in supported by flutter. it need initial date ie date when the date picker is opened, first and lat date are the lowest and highest date that can be selected.
  //future:data type in dart, it is an object from the future, it is an object which does not have a value yet but will have value in future.
  //future can have 'then' method which can be called, to which we can pass an anonymous function, it will get the value once the date is picked.it will executed once the value is get.
  //instead of using then method we can use 'async' at the beigining and then add the await keyword. we can use async and await when we get a future value. await tells that the pickedDate will have a value somepoint in the future, flutter should wait for that value.

  void _submitExpenseData(){
    final enteredAmount = double.tryParse(_amountController.text);//tryparse is a method build on to dart , takes string as an input returns a double if it is able to convert string to a double or returns null if it is not able to convert it. tryParse('hello') == null tryParse('1.2') == 1.2
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty || amountIsInvalid || _selectedDate == null) { // trimming remove excess leading or trailing whitespaces, can be called on a string//isEmpty is a build in property, can be called on lists or strings
      //show an error msg
      showDialog(//another build in function showDialog
          context: context,
          builder: (ctx) => AlertDialog(//alert msg
            title: const Text('Invalid input'),
            content: const Text('please make sure input(title,amount,date,category) is valid'),
            actions: [//actions to be performed
              TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child:const Text('Ok'))
            ],
          ),
      );// builder needs context as input and return a widget , content of the pop up message (an error msg).
      return;
    }

    widget.onAddExpense(
        Expense(
            title: _titleController.text,
            amount: enteredAmount,
            date: _selectedDate!,
            category: _selectedCategory)
    );//thingds declared in a class can be used in another class using 'widget'.
    Navigator.pop(context);
  }

  @override
  void dispose() {
   _titleController.dispose();
   _amountController.dispose();
    super.dispose();
  }
  // var _enteredTitle = '';
  // void _saveTitleInput(String inputValue){
  //   _enteredTitle = inputValue;
  // }
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            //onChanged: _saveTitleInput,//it is a function which recives a text ie the string enterd.istead of calling this function and saving , we can use texteditingcontrollers.
            controller: _titleController,//instead onChanged use controller
            decoration:const InputDecoration(
              label: Text('Title')
            ),
          ),//used to add text. has paramers like maxLength,keyBordType etc.label can be added by setting decoration
          Row(
            children:[
              Expanded(
                child: TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration:const InputDecoration(
                  prefixText: '\$ ',//dollar symbol will be shown as prefix.
                  label: Text('Amount')
                ),
                            ),
              ),
              const SizedBox(width: 16),
               Expanded(child: Row(
                 mainAxisAlignment: MainAxisAlignment.end,//to set the date picker to the left most side
                 crossAxisAlignment: CrossAxisAlignment.center,//to center vertically
                children: [
                    Text(_selectedDate == null ? 'No date selected': formatter.format(_selectedDate!)),//add intl package and formatter, then if selected date id null show message else format the date and show there. ! force dart to assume it wont be null.
                  IconButton(onPressed: _presentDatePicker,
                      icon:const Icon(Icons.calendar_month),
                  ),
                  ],
                ),
              )
            ],
          ),
          //since there is a row inside a row we must use expanded.

          const SizedBox(height: 16,),

          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                  items: Categorys.values.
                  map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name.toUpperCase(),
                        ),
                      ),
                  )
                      .toList(),//values is a list of enum Category, items want a list of dropdown menu items. use map to transform it from one type to another. map want a function which will be executed automatically by flutter for every list item.
                  onChanged: (value) {
                    if(value == null)
                      return;// if we return nothing else will be executed , return is the last statement to be executed.
                    setState(() {
                      _selectedCategory = value;
                    });
                  },//value that we get here is the value from the dropdown.
              ),

              const Spacer(),

              ElevatedButton(onPressed:  _submitExpenseData,
                //print(_enteredTitle);
                // print(_titleController.text);
                // print(_amountController.text);
                  child: Text('save Expenses'),
              ),
              TextButton(onPressed: () {
                Navigator.pop(context);//removes the overlay
              },
                  child: Text('cancel'),),
            ],
          )
        ],
      ),
    );
  }
}