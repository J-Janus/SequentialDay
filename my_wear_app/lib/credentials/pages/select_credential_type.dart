import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectCredentialPageState {
   
  CredentialType? item1;
  PlatformType? item2;
  bool item0;

  SelectCredentialPageState(this.item1, this.item2, [this.item0 = false]);

}

enum CredentialType{ credentialA, credentialB }
enum PlatformType{ platformA, platformB }



class SelectCredentialCubit extends Cubit<SelectCredentialPageState> {
  SelectCredentialCubit() : super(SelectCredentialPageState(null, null));

  CredentialType? credential = null;

  void nothingSelected() {
    this.credential = null;
    emit(SelectCredentialPageState(null, null));
  }

  void selectCredentialA() {
    this.credential = CredentialType.credentialA;
    emit(SelectCredentialPageState(CredentialType.credentialA, null, true));
  }

  void selectCredentialB() {
    this.credential = CredentialType.credentialB;
    emit(SelectCredentialPageState(CredentialType.credentialB, null, true));
  }

  void selectPlatformA() {
    emit(SelectCredentialPageState(this.credential, PlatformType.platformA, true));
  }

  void selectPlatformB() {
    emit(SelectCredentialPageState(this.credential, PlatformType.platformB, true));
  }

  void canclePlatform() {
    emit(SelectCredentialPageState(this.credential, null, true));
  }
}

class SelectCredentialPage extends StatefulWidget {
  const SelectCredentialPage({Key? key}) : super(key: key);

  @override
  State<SelectCredentialPage> createState() => _SelectCredentialPageState();
}

class _SelectCredentialPageState extends State<SelectCredentialPage> {
  bool showBottomButtons = false;
  String?
      highlightedTopButton;
  String?
      highlightedBottomButton;

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
              Positioned(
                top: centerOffset -
                    centerOffset / 2, 
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        if (state.item1==CredentialType.credentialA)
                          context
                              .read<SelectCredentialCubit>()
                              .nothingSelected();
                        else
                          context
                              .read<SelectCredentialCubit>()
                              .selectCredentialA();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: state.item1==CredentialType.credentialA
                            ? Colors.green
                            : null, 
                      ),
                      child: const Text('add T'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (state.item1==CredentialType.credentialB)
                          context
                              .read<SelectCredentialCubit>()
                              .nothingSelected();
                        else
                          context
                              .read<SelectCredentialCubit>()
                              .selectCredentialB();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: state.item1==CredentialType.credentialB
                            ? Colors.green
                            : null, 
                      ),
                      child: const Text('add B'),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: state.item0,
                child: Positioned(
                  top: centerOffset + 40, 
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                        if (state.item2==PlatformType.platformA)
                          context
                              .read<SelectCredentialCubit>()
                              .canclePlatform();
                        else
                          context
                              .read<SelectCredentialCubit>()
                              .selectPlatformA();
                      }, 
                        style: ElevatedButton.styleFrom(
                          backgroundColor: state.item2==PlatformType.platformA
                              ? Colors.blue
                              : null, 
                        ),
                        child: const Text('add X'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                        if (state.item2==PlatformType.platformB)
                          context
                              .read<SelectCredentialCubit>()
                              .canclePlatform();
                        else
                          context
                              .read<SelectCredentialCubit>()
                              .selectPlatformB();
                      }, 
                        style: ElevatedButton.styleFrom(
                          backgroundColor: state.item2==PlatformType.platformB
                              ? Colors.blue
                              : null, 
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
