import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController mapController;//isso aqui é o MapController, é obrigatório
  Position posicao = Position();

  //Essa função getLocation() pega a latitude e longitude atuais do usuário
  //só que não atualiza (se eu mudar de lugar, ela não vai pegar a posição dnv)
  Future<Position>getLocation() async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy:LocationAccuracy.high);
    posicao = position;
    marker.add(
        Marker(markerId: MarkerId("Eu"),
            draggable: false,
            position: LatLng(posicao.latitude, posicao.longitude),
            infoWindow: InfoWindow(title: "Eu")
        )
    );
    setState(() {});
  }
  //esse marker é o marcador, aquele simbolo vermelho no mapa. É um tipo List<>
  List<Marker> marker = [];
  @override
  void initState() {
    getLocation();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child:
      //esse GoogleMap é justamente o q constrói o mapa.
      //Ele precisa de uma posição inicial da câmera pra mostrar.
      //Esse initialCameraPosition serve pra isso, ele recebe um CameraPosition
      //Esse CameraPosition recebe um alvo(target) q usa LatLng
      // O LatLng é como se fosse o ponto no plano, com a latitude e longitude
      //Tem o nível de zoom também, q serve para... dar zoom?
      //O onMapCreated é pra fazer alguma coisa assim que o mapa for criado, mas
      //nesse caso não precisa.
      GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(posicao.latitude, posicao.longitude),
          zoom: 16.0,
        ),
        markers: Set.from(marker),
        onMapCreated: (mapController) {

        },
      ),
    );
  }

}
