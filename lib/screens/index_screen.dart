// import 'dart:js_util';
import 'dart:io';

import 'package:agenda/models/agenda.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Indexscreen extends StatefulWidget {
  const Indexscreen({
    Key? key,
  }) : super(key: key);

  @override
  State<Indexscreen> createState() => _IndexscreenState();
}

class _IndexscreenState extends State<Indexscreen> {
  String _orderSelected = "";
  PickerDateRange? _fechaSelec;

  _fechaSelecDialog(fechaSelec) {
    _fechaSelec = fechaSelec;
  }

  _crearCitaDialog({Agenda? agenda}) {
    agenda ??= Agenda(time: DateTime.now());

    showDialog(
        context: context,
        builder: ((context) => _GuardarCitaDialog(
              fecharangoSelec: _fechaSelec,
              fechaSelec:
                  agenda!.id == 0 ? _fechaSelec?.startDate : agenda.time,
              agenda: agenda,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        toolbarHeight: 90,
        elevation: 5,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
          Text(
            "Calendario",
            style: TextStyle(fontSize: 40, color: Colors.grey),
          ),
          Text(
            "App",
            style: TextStyle(fontSize: 40, color: Colors.white),
          ),
        ]),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Row(
              children: [
                DropdownButton(
                    items: <String>["By date", "By creation"]
                        .map((i) => DropdownMenuItem<String>(
                              value: i,
                              child: Text(
                                i,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                              ),
                            ))
                        .toList(),
                    hint: _orderSelected == ""
                        ? const Text(
                            "Seleccionar",
                            style: TextStyle(color: Colors.white),
                          )
                        : Text(
                            _orderSelected,
                            style: const TextStyle(color: Colors.white),
                          ),
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
      body: _Content(
          key: Key(_orderSelected),
          crearCitaDialog: _crearCitaDialog,
          fechaSelecDialog: _fechaSelecDialog,
          orden: _orderSelected),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          _crearCitaDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _UserAvatar extends StatelessWidget {
  const _UserAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundImage: AssetImage("assets/images/mikedev.jpg"),
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

class _ConfirmDialog extends StatelessWidget {
  final Function confirm;
  final String message;

  const _ConfirmDialog(
      {super.key, required this.confirm, this.message = "Confirm"});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Por favor confirmar"),
      content: Text(message),
      actions: [
        TextButton(
            onPressed: () {
              confirm();
              Navigator.of(context).pop();
            },
            child: const Text("Si")),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("No"))
      ],
    );
  }
}

class _ProfileDialog extends StatelessWidget {
  final _key = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _avatarController = TextEditingController();

  _ProfileDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 100,
          maxWidth: 450,
          minHeight: 100,
          maxHeight: 290,
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .4,
          height: MediaQuery.of(context).size.height * .404,
          child: Form(
              key: _key,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: "Nombre", border: OutlineInputBorder()),
                      controller: _nameController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: "Avatar", border: OutlineInputBorder()),
                      controller: _avatarController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.purple,
                            elevation: 4),
                        onPressed: () {
                          final sizeWidget = _key.currentContext!.size;
                          print(sizeWidget);
                        },
                        child: const Text("Actualizar"))
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

class _GuardarCitaDialog extends StatefulWidget {
  _GuardarCitaDialog(
      {super.key, this.fecharangoSelec, this.fechaSelec, required this.agenda});

  DateTime? fechaSelec;
  final PickerDateRange? fecharangoSelec;
  final Agenda agenda;

  @override
  State<_GuardarCitaDialog> createState() => _GuardarCitaDialogState();
}

class _GuardarCitaDialogState extends State<_GuardarCitaDialog> {
  final _key = GlobalKey<FormState>();

  final _nombreController = TextEditingController();

  final _citaController = TextEditingController();

  @override
  void initState() {
    _nombreController.text = widget.agenda.title;
    _citaController.text = widget.agenda.content;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: ConstrainedBox(
        constraints: const BoxConstraints(
            minWidth: 100, maxWidth: 450, minHeight: 100, maxHeight: 700),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.7,
          child: Form(
              key: _key,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SfDateRangePicker(
                      selectionColor: Colors.blueGrey,
                      selectionMode: DateRangePickerSelectionMode.single,
                      initialSelectedDate: widget.fechaSelec == null
                          ? DateTime.now()
                          : widget.fechaSelec!,
                      onSelectionChanged: (dateRangePickerSelection) {
                        print(dateRangePickerSelection.value);
                        widget.fechaSelec = dateRangePickerSelection.value;

                        setState(() {});
                      },
                    ),
                    if (widget.fechaSelec == null)
                      const Text(
                        "***Fecha no seleccionada***",
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: "Título", border: OutlineInputBorder()),
                      controller: _nombreController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Debes escribir un Título";
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      maxLines: 3,
                      minLines: 3,
                      decoration: const InputDecoration(
                          labelText: "Cita", border: OutlineInputBorder()),
                      controller: _citaController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Debes escribir una cita";
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          print("Guardar!");
                        }
                        print(widget.fechaSelec);
                      },
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.purple,
                          elevation: 4),
                      child: const Text("Guardar"),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

class _Content extends StatefulWidget {
  Function crearCitaDialog;
  Function fechaSelecDialog;
  String orden;

  _Content(
      {super.key,
      required this.crearCitaDialog,
      required this.fechaSelecDialog,
      required this.orden});

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  List<Agenda> agendas = [];
  List<Agenda> agendasFiltered = [];

  @override
  void initState() {
    super.initState();

    agendas.addAll([
      Agenda(
          id: 8,
          title: "prueba 8",
          content: "Contenido prueba",
          time: DateTime.now()),
      Agenda(
          id: 10,
          title: "prueba 10",
          content: "Contenido prueba",
          time: DateTime.now()),
      Agenda(
          id: 0,
          title: "prueba 0",
          content: "Contenido prueba",
          time: DateTime.now()),
      Agenda(
          id: 1,
          title: "prueba 1",
          content: "Contenido prueba",
          time: DateTime.now()),
      Agenda(
          id: 13,
          title: "prueba 13",
          content: "Contenido prueba",
          time: DateTime.now().add(const Duration(days: 2))),
      Agenda(
          id: 11,
          title: "prueba 11",
          content: "Contenido prueba",
          time: DateTime.now().subtract(const Duration(days: 5))),
      Agenda(
          id: 12,
          title: "prueba 12",
          content: "Contenido prueba",
          time: DateTime.now().add(const Duration(days: 6))),
      Agenda(
          id: 16,
          title: "prueba 16",
          content: "Contenido prueba",
          time: DateTime.now().subtract(const Duration(days: 7)))
    ]);

    agendasFiltered = agendas;

    if (widget.orden == "By date") {
      agendasFiltered.sort((a, b) => a.time.compareTo(b.time));
    } else {
      agendasFiltered.sort((a, b) => a.id.compareTo(b.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 3,
            child: Column(
              children: [
                SfDateRangePicker(
                  selectionColor: Colors.blueGrey,
                  startRangeSelectionColor: Colors.deepPurple,
                  endRangeSelectionColor: Colors.deepPurple,
                  rangeSelectionColor: Colors.purple,
                  selectionMode: DateRangePickerSelectionMode.range,
                  // initialSelectedRange: PickerDateRange(
                  //   DateTime.now().subtract(const Duration(days: 3)),
                  //   DateTime.now().add(const Duration(days: 3)),
                  // ),
                  showActionButtons: true,

                  confirmText: "Listo",
                  cancelText: "Volver",
                  onCancel: () {
                    agendasFiltered = agendas;
                    setState(() {});
                  },
                  onSubmit: (dateRange) {
                    agendasFiltered = [];
                    if (dateRange is PickerDateRange) {
                      for (var i = 0; i < agendas.length; i++) {
                        if (agendas[i].time.compareTo(dateRange.startDate!) >=
                                0 &&
                            agendas[i].time.compareTo(dateRange.endDate!) <=
                                0) {
                          agendasFiltered.add(agendas[i]);
                        }

                        setState(() {});
                      }
                    }
                    print(dateRange);
                  },
                  onSelectionChanged: (dateRange) {
                    print(dateRange);
                    widget.fechaSelecDialog(dateRange.value);
                  },
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
                  label: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Añadir Cita",
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ),
                  onPressed: () {
                    widget.crearCitaDialog();
                  },
                )
              ],
            )),
        Expanded(
            flex: 5,
            child: agendasFiltered.isEmpty
                ? const _PageEmpty()
                : ListView.builder(
                    itemCount: agendasFiltered.length,
                    itemBuilder: ((context, index) => DelayedDisplay(
                          delay: const Duration(milliseconds: 10),
                          slidingBeginOffset: const Offset(0, 1),
                          fadeIn: true,
                          child: ListTile(
                            title: Card(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AnimatedContainer(
                                    width: 0,
                                    duration: const Duration(milliseconds: 280),
                                  ),
                                  GestureDetector(
                                    onTap: (() => widget.crearCitaDialog(
                                        agenda: agendasFiltered[index])),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            agendasFiltered[index].title,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "${agendasFiltered[index].time.day}-${agendasFiltered[index].time.month}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 99, 99, 99)),
                                                ),
                                                const SizedBox(height: 30),
                                                Text(
                                                  agendasFiltered[index]
                                                      .content,
                                                  style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 99, 99, 99)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            leading: const Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                            ),
                            trailing: GestureDetector(
                              onTap: (() {
                                showDialog(
                                  context: context,
                                  builder: (context) => _ConfirmDialog(
                                      message:
                                          "Seguro que desea realizar este cambio?",
                                      confirm: () {
                                        agendas.remove(agendasFiltered[index]);
                                        setState(() {});
                                      }),
                                );
                              }),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        )))),
      ],
    );
  }
}

class _PageEmpty extends StatelessWidget {
  const _PageEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.purple.shade50,
          shape: BoxShape.rectangle,
        ),
        child: const Center(
          child: Text(
            "Sin citas",
            style: TextStyle(
                color: Colors.purple,
                fontStyle: FontStyle.italic,
                fontSize: 30,
                fontWeight: FontWeight.w100),
          ),
        ),
      ),
    );
  }
}
