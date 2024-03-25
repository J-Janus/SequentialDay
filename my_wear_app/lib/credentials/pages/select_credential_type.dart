import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectCredentialPageState {
   
  CredentialType? item1;
  PlatformType? item2;
  bool item0;

  SelectCredentialPageState(this.item1, this.item2, [this.item0 = false]);

  bool is_credential_type(){
    if (this.item1==null)
      return false;
    else
      return true;
  }
  bool is_platform_type(){
    if (this.item2==null)
      return false;
    else
      return true;
  }

  bool is_noting_selected(){
     return this.item0;
  }
}

enum CredentialType{ CredentialA, CredentialB }
enum PlatformType{ PlatformA, PlatformB }


enum SelectCredentialPageOptions {
  NothingSelected,
  selectCredentialTypeA,
  selectCredentialTypeB,
  CredentialAPlatformA,
  CredentialAPlatformB,
  addCredential,
  filledCredential
}

class SelectCredentialCubit extends Cubit<SelectCredentialPageState> {
  SelectCredentialCubit() : super(SelectCredentialPageState(null, null));

  void nothingSelected() {
    emit(SelectCredentialPageState(null, null));
  }

  void selectCredentialA() {
    emit(SelectCredentialPageState(CredentialType.CredentialA, null, true));
  }

  void selectCredentialB() {
    emit(SelectCredentialPageState(CredentialType.CredentialB, null, true));
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
      child: BlocBuilder<SelectCredentialCubit, SelectCredentialPageState>(
        builder: (context, state) {
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              // Pozycjonowanie górnych przycisków 20 pikseli powyżej środka ekranu
              Positioned(
                top: centerOffset -
                    centerOffset / 2, // 20 pikseli powyżej środka
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        if (state.item1==CredentialType.CredentialA)
                          context
                              .read<SelectCredentialCubit>()
                              .nothingSelected();
                        else
                          context
                              .read<SelectCredentialCubit>()
                              .selectCredentialA();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: state.item1==CredentialType.CredentialA
                            ? Colors.green
                            : null, // Podświetlenie jeśli aktywny
                      ),
                      child: const Text('add T'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (state.item1==CredentialType.CredentialB)
                          context
                              .read<SelectCredentialCubit>()
                              .nothingSelected();
                        else
                          context
                              .read<SelectCredentialCubit>()
                              .selectCredentialB();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: state.item1==CredentialType.CredentialB
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
                visible: state.item0,
                child: Positioned(
                  top: centerOffset + 40, // 20 pikseli poniżej środka
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () => setState(() =>
                            highlightedBottomButton =
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
                        onPressed: () => setState(() =>
                            highlightedBottomButton =
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
          );
        },
      ),
    );
  }
}
