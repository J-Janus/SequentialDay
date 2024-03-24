import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SelectCredentialPageState {
  NothingSelected,
  selectCredentialType,
  addCredential,
  filledCredential
}

class SelectCredentialCubit extends Cubit<SelectCredentialPageState> {
  SelectCredentialCubit() : super(SelectCredentialPageState.NothingSelected);

  void nothingSelected() {
    emit(SelectCredentialPageState.NothingSelected);
  }

  void selectCredential() {
    emit(SelectCredentialPageState.NothingSelected);
  }

  void selectCredentialType() {
    emit(SelectCredentialPageState.selectCredentialType);
  }

  void addCredential() {
    emit(SelectCredentialPageState.addCredential);
  }

  void fillCredential() {
    emit(SelectCredentialPageState.filledCredential);
  }
}

class DynamicButtonsPage extends StatefulWidget {
  const DynamicButtonsPage({Key? key}) : super(key: key);

  @override
  State<DynamicButtonsPage> createState() => _DynamicButtonsPageState();
}

class _DynamicButtonsPageState extends State<DynamicButtonsPage> {
  bool showBottomButtons = false;
  String?
      highlightedTopButton; // Zmienna do śledzenia podświetlonego górnego przycisku
  String?
      highlightedBottomButton; // Zmienna do śledzenia podświetlonego dolnego przycisku

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final centerOffset = screenHeight / 2; // Środek ekranu

    return BlocProvider(
      create: (context) => SelectCredentialCubit(),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // Pozycjonowanie górnych przycisków 20 pikseli powyżej środka ekranu
          Positioned(
            top: centerOffset - centerOffset / 2, // 20 pikseli powyżej środka
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => setState(() {
                    showBottomButtons = true;
                    highlightedTopButton = 'T'; // Podświetlenie przycisku T
                  }),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: highlightedTopButton == 'T'
                        ? Colors.green
                        : null, // Podświetlenie jeśli aktywny
                  ),
                  child: const Text('add T'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => setState(() {
                    showBottomButtons = true;
                    highlightedTopButton = 'B'; // Podświetlenie przycisku B
                  }),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: highlightedTopButton == 'B'
                        ? Colors.green
                        : null, // Podświetlenie jeśli aktywny
                  ),
                  child: const Text('add B'),
                ),
              ],
            ),
          ),
          // Pozycjonowanie dolnych przycisków 20 pikseli poniżej środka ekranu
          Visibility(
            visible: showBottomButtons,
            child: Positioned(
              top: centerOffset + 40, // 20 pikseli poniżej środka
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () => setState(() => highlightedBottomButton =
                        'X'), // Podświetlenie przycisku X
                    style: ElevatedButton.styleFrom(
                      backgroundColor: highlightedBottomButton == 'X'
                          ? Colors.blue
                          : null, // Podświetlenie jeśli aktywny
                    ),
                    child: const Text('add X'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => setState(() => highlightedBottomButton =
                        'Y'), // Podświetlenie przycisku Y
                    style: ElevatedButton.styleFrom(
                      backgroundColor: highlightedBottomButton == 'Y'
                          ? Colors.blue
                          : null, // Podświetlenie jeśli aktywny
                    ),
                    child: const Text('add Y'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
