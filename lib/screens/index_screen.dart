import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  String _orderSelected = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          toolbarHeight: 90,
          elevation: 5,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Todo",
                style: TextStyle(fontSize: 40, color: Colors.grey),
              ),
              Text(
                "App",
                style: TextStyle(fontSize: 40, color: Colors.white),
              )
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                children: [
                  DropdownButton(
                      items: <String>["By date", "By creation"]
                          .map((i) => DropdownMenuItem<String>(
                                child: Text(i),
                                value: i,
                              ))
                          .toList(),
                      hint: _orderSelected == ""
                          ? const Text(
                              "Filter",
                              style: TextStyle(color: Colors.white),
                            )
                          : Text(_orderSelected,
                              style: const TextStyle(color: Colors.white)),
                      onChanged: (value) {
                        setState(() {
                          _orderSelected = value.toString();
                        });
                      }),
                  const _UserAvatar(),
                ],
              ),
            )
          ],
        ),
        body: const _Content());
  }
}

class _UserAvatar extends StatelessWidget {
  const _UserAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundImage: AssetImage("assets/images/user.jpg"),
        ),
      ),
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return _ProfileDialog();
            });
      },
    );
  }
}

class _ProfileDialog extends StatelessWidget {
  final _key = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _avatarController = TextEditingController();

  _ProfileDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: ConstrainedBox(
        constraints: const BoxConstraints(
            minWidth: 100, maxWidth: 400, minHeight: 100, maxHeight: 280),
        child: SizedBox(
            width: MediaQuery.of(context).size.width * .3,
            height: MediaQuery.of(context).size.height * .3,
            child: Form(
              key: _key,
              child: SingleChildScrollView(
                  child: Column(children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/images/user.jpg"),
                  ),
                ),
                TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Name", border: OutlineInputBorder()),
                    controller: _nameController),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Avatar", border: OutlineInputBorder()),
                    controller: _avatarController),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.purple,
                        elevation: 4),
                    onPressed: () {
                      //final sizeWidget = _key.currentContext!.size;
                      print('was pressed!');
                    },
                    child: const Text('Update'))
              ])),
            )),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Container(
                color: Colors.yellow,
                child: SfDateRangePicker(
                  startRangeSelectionColor: Colors.purple,
                  endRangeSelectionColor: Colors.purple,
                  selectionMode: DateRangePickerSelectionMode.range,
                  onSelectionChanged: (dataRange) {
                    print(dataRange.value);
                  },
                ))),
        Expanded(
            flex: 3,
            child: ListView.builder(
                itemCount: 30,
                itemBuilder: ((context, index) => DelayedDisplay(
                      delay: const Duration(milliseconds: 5),
                      slidingBeginOffset: const Offset(0, 1),
                      fadeIn: true,
                      child: Card(
                        child: ListTile(
                          title: Text("Todo $index"),
                          leading: const Icon(Icons.check_circle_outline,
                              color: Colors.green),
                          trailing: const Icon(Icons.delete, color: Colors.red),
                          subtitle: Row(
                            children: [
                              Text("date ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text("Contenido del to do")
                            ],
                          ),
                        ),
                      ),
                    )))),
      ],
    );
  }
}
