import 'package:car_track/models/car.dart';
import 'package:car_track/actions/actions.dart';
import 'package:car_track/constants/route_paths.dart' as routes;
import 'package:car_track/locator.dart';
import 'package:car_track/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:car_track/models/app_state.dart';

@immutable
class NewCar3ViewModel {
  final Function updateNewCar;
  final Car novoCarro;

  NewCar3ViewModel({this.updateNewCar, this.novoCarro});
}

class NewCar3Screen extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();
  String value = "";

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, NewCar3ViewModel>(
        builder: (context, NewCar3ViewModel viewModel) {
      return new Scaffold(
          body: Builder(
        builder: (context) => Container(
            color: Colors.white,
            child: Stack(
              children: [
                Positioned(
                  top: 32,
                  left: 8,
                  child: IconButton(
                      icon: Icon(
                        Icons.chevron_left,
                        color: Colors.grey[700],
                        size: 32.0,
                        semanticLabel: 'Voltar',
                      ),
                      onPressed: () => _navigationService.goBack()),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(16, 80, 0, 16),
                    child: Text('Como quer chamar seu carro?',
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700]))),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 80),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: TextFormField(
                        onChanged: (text) {
                          value = text;
                        },
                        initialValue: viewModel.novoCarro.modelo,
                        decoration: InputDecoration(
                          labelText: 'Quero chamar de',
                          filled: true,
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 32,
                  right: 16,
                  child: RaisedButton(
                    onPressed: () {
                      if (value == "") {
                        value = viewModel.novoCarro.modelo;
                      }
                      viewModel.updateNewCar(new Car(
                          maisUsado: null,
                          marca: viewModel.novoCarro.marca,
                          modelo: viewModel.novoCarro.modelo,
                          nome: value));
                    },
                    color: Colors.deepPurpleAccent[700],
                    padding: EdgeInsets.fromLTRB(13, 12, 13, 12),
                    child: Row(
                      children: <Widget>[
                        Text('AVANÇAR',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        SizedBox(width: 8),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                          size: 24.0,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )),
      ));
    }, converter: (store) {
      return new NewCar3ViewModel(
          updateNewCar: (Car novoCarro) {
            store.dispatch(new UpdateNewCarAction(novoCarro));
            _navigationService.navigateTo(routes.NewCarDetailsRoute);
          },
          novoCarro: store.state.novoCarro);
    });
  }
}
