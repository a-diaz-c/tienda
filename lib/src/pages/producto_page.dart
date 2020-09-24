import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:tienda/src/components/dialogPregunta.dart';

import 'package:tienda/src/components/drawer.dart';
import 'package:tienda/src/components/footer.dart';
import 'package:tienda/src/components/navbar.dart';

import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:tienda/src/providers/productos_providers.dart';

class ProductoPage extends StatefulWidget {
  String id;
  ProductoPage({Key key, this.id = ' '}) : super(key: key);

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage>
    with SingleTickerProviderStateMixin {
  ScrollController _rrectController = ScrollController();
  ProductosProviders providers = ProductosProviders();
  Map producto;
  TabController _tabController;
  TextEditingController _controller = TextEditingController()..text = "1";

  @override
  void initState() {
    super.initState();
    producto = providers.buscarProducto(widget.id);
    _tabController = new TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    double _anchoPantalla = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: DrawerComponent(),
      body: DraggableScrollbar.rrect(
        alwaysVisibleScrollThumb: true,
        controller: _rrectController,
        backgroundColor: Colors.grey[300],
        child: ListView(
          controller: _rrectController,
          children: [
            Navbar(),
            LayoutBuilder(builder: (context, constraints) {
              if (MediaQuery.of(context).size.width > 900) {
                return _cardProducto(_anchoPantalla * 0.60);
              } else {
                return _cardProductoMovil(_anchoPantalla * 0.90);
              }
            }),
            _tabs(MediaQuery.of(context).size.width > 900
                ? _anchoPantalla * 0.60
                : _anchoPantalla * 0.90),
            footer(),
          ],
        ),
      ),
    );
  }

  Widget _cardProducto(double ancho) {
    double anchoImagen = ancho * 0.50;
    double altoIamgen = ancho * 0.50;
    return Center(
      child: Container(
        width: ancho,
        padding: EdgeInsets.symmetric(vertical: 50.0),
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _imagenProducto(anchoImagen, altoIamgen),
                    SizedBox(width: 20),
                    _textosProducto(20.0),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardProductoMovil(double ancho) {
    return Center(
      child: Container(
        width: ancho,
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _imagenProducto(ancho * 0.60, ancho * 0.60),
                  ],
                ),
                Row(
                  children: [
                    _textosProducto(20.0),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _imagenProducto(double ancho, double alto) {
    return Container(
      child: Image.network(
        producto['imagen'],
        width: ancho,
        height: alto,
      ),
    );
  }

  Widget _textosProducto(double sizeTitulo) {
    double textDatosProductos = sizeTitulo * 0.60;
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _nombreProducto(sizeTitulo),
          SizedBox(height: 10.0),
          Container(
            child: Row(
              children: [
                Text(
                  "Precio: ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: textDatosProductos),
                ),
                Text(
                  producto['precio'],
                  style: TextStyle(fontSize: textDatosProductos),
                )
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            child: Row(
              children: [
                Text(
                  "Marca: ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: textDatosProductos),
                ),
                Text(
                  "TRUPER",
                  style: TextStyle(fontSize: textDatosProductos),
                )
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "Marca: ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: textDatosProductos),
                ),
                Text(
                  "CMA0301050027",
                  style: TextStyle(fontSize: textDatosProductos),
                )
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "Unidad de venta: ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: textDatosProductos),
                ),
                Text(
                  "Kilos",
                  style: TextStyle(fontSize: textDatosProductos),
                )
              ],
            ),
          ),
          _iconos(
              Icons.local_shipping,
              "Envíos Gratis",
              "Monto mínimo de compra puede variar por tienda y zona",
              sizeTitulo * 1.42,
              colorTexto: Colors.orange),
          SizedBox(height: 15.0),
          _iconos(Icons.verified_user, "Garantía Construrama",
              "Seguridad en todas tus compras", sizeTitulo * 1.42,
              colorTexto: Colors.green),
          SizedBox(height: 15.0),
          _iconos(
              Icons.local_post_office,
              "Click & Pick up",
              "Compra en línea y recoge tu pedido en tienda",
              sizeTitulo * 1.42),
          SizedBox(height: sizeTitulo * 1.14),
          _caracteristicasProducto(sizeTitulo),
          SizedBox(height: sizeTitulo * 1.14),
          Row(
            children: [
              _botonCarrito(),
              SizedBox(width: 10.0),
              //Text('Cantidad '),
              _inputCantidad(),
            ],
          ),
          SizedBox(height: 10.0),
          //_botonComprar()
        ],
      ),
    );
  }

  Widget _nombreProducto(double size) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: SelectableText(
        producto['nombre'],
        style: TextStyle(fontSize: size, fontWeight: FontWeight.normal),
      ),
    );
  }

  Widget _caracteristicasProducto(double sizeTexto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: SelectableText(
            'Características',
            style: TextStyle(
                fontSize: sizeTexto * 0.571, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          child: SelectableText(
            'Clavo negro para concreto de 2 pulgadas (50.8 Mm). Fabricado en acero al carbono. Con cuerpo rolado especial que facilita la penetración y proporciona mayor resistencia.',
            style: TextStyle(fontSize: sizeTexto * 0.50),
          ),
        ),
      ],
    );
  }

  Widget _iconos(IconData icono, String titulo, String subtitulo, double size,
      {Color colorTexto}) {
    if (colorTexto == null) colorTexto = Colors.black;
    return Container(
      child: Row(
        children: [
          Icon(
            icono,
            size: size,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size * 0.40,
                      color: colorTexto),
                ),
                Text(subtitulo)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _botonCarrito() {
    return RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(color: Colors.blue)),
      child: Text(
        "Agregar al carrito",
        style: TextStyle(color: Colors.blue, fontSize: 15.0),
      ),
      color: Colors.white,
      onPressed: () {
        Map<String, dynamic> nuevo = {
          'id': producto['clave_producto'],
          'nombre': producto['nombre'],
          'precio': double.parse(producto['precio']),
          'imagen': producto['imagen'],
          'cantidad': int.parse(_controller.text),
        };
        providers.addProductoCarrito(nuevo);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return DialogPregunta(
              titulo: 'Agregado al Carrito',
              contenido: '¿Ir al carrito?',
            );
          },
        );
      },
    );
  }

  Widget _inputCantidad() {
    return Container(
      width: 40.0,
      height: 30.0,
      foregroundDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: Colors.blueGrey,
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              style: TextStyle(
                fontSize: 12.0,
              ),
              controller: _controller,
              keyboardType: TextInputType.numberWithOptions(
                decimal: false,
                signed: true,
              ),
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(0.0),
            height: 25.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: InkWell(
                    child: Icon(
                      Icons.arrow_drop_up,
                      size: 10.0,
                    ),
                    onTap: () {
                      int currentValue = int.parse(_controller.text);
                      setState(() {
                        currentValue++;
                        _controller.text =
                            (currentValue).toString(); // incrementing value
                      });
                    },
                  ),
                ),
                InkWell(
                  child: Icon(
                    Icons.arrow_drop_down,
                    size: 10.0,
                  ),
                  onTap: () {
                    int currentValue = int.parse(_controller.text);
                    setState(() {
                      currentValue--;
                      _controller.text = (currentValue > 0 ? currentValue : 0)
                          .toString(); // decrementing value
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tablaTecnica() {
    return Table(
      border: TableBorder(
        horizontalInside:
            BorderSide(width: 1, color: Colors.grey, style: BorderStyle.solid),
      ),
      children: [
        TableRow(children: [
          ..._textTabla(
            "Usos",
            "Para la construcción de muros y paredes.",
          ),
          ..._textTabla("Altura", "15 cm"),
        ]),
        TableRow(children: [
          ..._textTabla("Ancho", "20 cm"),
          ..._textTabla("Longitud", "40 cm"),
        ]),
        TableRow(children: [
          ..._textTabla("Material", "Concreto"),
          ..._textTabla("", ""),
        ])
      ],
    );
  }

  Widget _tablaTecnicaMovil() {
    return Table(
      border: TableBorder(
        horizontalInside:
            BorderSide(width: 1, color: Colors.grey, style: BorderStyle.solid),
      ),
      children: [
        TableRow(children: [
          ..._textTabla(
            "Usos",
            "Para la construcción de muros y paredes.",
          ),
        ]),
        TableRow(children: [
          ..._textTabla("Altura", "15 cm"),
        ]),
        TableRow(children: [
          ..._textTabla("Ancho", "20 cm"),
        ]),
        TableRow(children: [
          ..._textTabla("Longitud", "40 cm"),
        ]),
        TableRow(children: [
          ..._textTabla("Material", "Concreto"),
        ]),
        TableRow(children: [
          ..._textTabla("Material", "Concreto"),
        ])
      ],
    );
  }

  List<Widget> _textTabla(String titulo, String contenido) {
    return [
      Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          color: Colors.grey[200],
          child: Text(
            titulo,
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(contenido)),
    ];
  }

  Widget _tabs(double ancho) {
    return Center(
      child: Container(
        width: ancho,
        padding: EdgeInsets.only(bottom: 20.0),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: 40.0,
              child: TabBar(
                tabs: [
                  Tab(
                    child: Container(
                      height: 25,
                      child: Text(
                        "Descripcion",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      height: 25,
                      child: Text(
                        "Especificaciones",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      height: 25,
                      child: Text(
                        "Calificaciones",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      height: 25,
                      child: Text(
                        "Adjuntos",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
                controller: _tabController,
                indicatorColor: Colors.blue,
                indicatorSize: TabBarIndicatorSize.tab,
              ),
            ),
            Center(
              child: [
                _decripcion(),
                MediaQuery.of(context).size.width > 900
                    ? _tablaTecnica()
                    : _tablaTecnicaMovil(),
                _cardCalificacion(ancho),
                Text("This is notification Tab View")
              ][_tabController.index],
            ),
          ],
        ),
      ),
    );
  }

  Widget _decripcion() {
    return Html(
      data: """<p>&nbsp;</p>
<h3 style="text-align: center; color: #3f7320;"><span style="border-bottom: 4px solid #c82828;">Haga click aqu&iacute; </span> para editar este texto o pegarlo aqu&iacute; para convertirlo a HTML 😁</h3>
<!-- Este comentario es visible solo en el editor fuente -->
<p><strong>Este demo le permite probar las caracter&iacute;sticas de este editor. Escriba algo en uno de los campos y vea el otro cambiando en tiempo real. </strong></p>
<p><strong>Configure las opciones de limpieza y haga clic&nbsp;</strong></p>
<p>Trabaje con cualquiera de los editores y vea el otro cambiando en tiempo real:</p>
<p>&nbsp;</p>
<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Revisa <a target="_blank" rel="nofollow noopener" href="https://geekprank.com/">GeekPrank</a> para buenas bromas en l&iacute;nea.</p>""",
    );
  }

  Widget _cardCalificacion(double ancho) {
    return Center(
      child: Container(
        width: ancho,
        padding: EdgeInsets.only(bottom: 20.0),
        child: Card(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Calificación de producto",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
                LayoutBuilder(builder: (context, constraints) {
                  print(MediaQuery.of(context).size.width);
                  if (MediaQuery.of(context).size.width > 900) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: ancho / 2,
                          padding: EdgeInsets.only(left: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _puntiacion(MainAxisAlignment.start,
                                  (ancho * 0.5) * 0.12),
                              _totalCalificaciones(MainAxisAlignment.start),
                              _puntuajePorEstrella(
                                  5, 0.8, 10, MainAxisAlignment.start, 100),
                              _puntuajePorEstrella(
                                  4, 0.2, 2, MainAxisAlignment.start, 100),
                              _puntuajePorEstrella(
                                  3, 0.0, 0, MainAxisAlignment.start, 100),
                              _puntuajePorEstrella(
                                  2, 0, 0, MainAxisAlignment.start, 100),
                              _puntuajePorEstrella(
                                  1, 0, 0, MainAxisAlignment.start, 100),
                            ],
                          ),
                        ),
                        SizedBox(width: 20.0),
                        _seccionComentarios(MainAxisAlignment.center),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        _puntiacion(
                            MainAxisAlignment.center, (ancho * 0.5) * 0.15),
                        _totalCalificaciones(
                          MainAxisAlignment.center,
                        ),
                        _puntuajePorEstrella(5, 0.8, 10,
                            MainAxisAlignment.center, (ancho * 0.7)),
                        _puntuajePorEstrella(
                            4, 0.2, 2, MainAxisAlignment.center, (ancho * 0.7)),
                        _puntuajePorEstrella(
                            3, 0.0, 0, MainAxisAlignment.center, (ancho * 0.7)),
                        _puntuajePorEstrella(
                            2, 0, 0, MainAxisAlignment.center, (ancho * 0.7)),
                        _puntuajePorEstrella(
                            1, 0, 0, MainAxisAlignment.center, (ancho * 0.7)),
                        InkWell(
                          child: Text(
                            "Ver todos los comentarios",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onTap: () => {},
                        )
                      ],
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _puntiacion(MainAxisAlignment main, double size) {
    return Row(
      mainAxisAlignment: main,
      children: [
        Text(
          "3.0",
          style: TextStyle(
              fontSize: size,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900]),
        ),
        IconTheme(
          data: IconThemeData(
            color: Colors.amber,
            size: size,
          ),
          child: StarDisplay(value: 3),
        )
      ],
    );
  }

  Widget _totalCalificaciones(MainAxisAlignment main) {
    return Row(
      mainAxisAlignment: main,
      children: [
        Text(
          "12 calificaciones",
          style: TextStyle(fontSize: 18.0),
        )
      ],
    );
  }

  Widget _puntuajePorEstrella(int numeroEstrella, double porcentaje,
      int comentarios, MainAxisAlignment main, double ancho) {
    return Row(
      mainAxisAlignment: main,
      children: [
        Icon(Icons.star),
        Text(numeroEstrella.toString()),
        LinearPercentIndicator(
          width: ancho,
          lineHeight: 12.0,
          percent: porcentaje,
          progressColor: Colors.green[600],
        ),
        Text(comentarios.toString())
      ],
    );
  }

  Widget _seccionComentarios(MainAxisAlignment main) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: main,
          children: [
            Container(
                padding: EdgeInsets.only(right: 10.0),
                child: Text(
                  "Comentarios recientes",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            InkWell(
              child: Text("Ver todos"),
              onTap: () => {},
            )
          ],
        ),
        _comentario(main),
        _comentario(main),
      ],
    );
  }

  Widget _comentario(MainAxisAlignment main) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: main,
            children: [
              StarDisplay(
                value: 5,
                tamanio: 20,
              )
            ],
          ),
          SizedBox(height: 3.0),
          Row(
            mainAxisAlignment: main,
            children: [Text("Satisfecho con mi compra")],
          ),
          SizedBox(height: 3.0),
          Row(
            mainAxisAlignment: main,
            children: [
              Text("23/04/20"),
            ],
          )
        ],
      ),
    );
  }
}

class StarDisplay extends StatelessWidget {
  final int value;
  final double tamanio;
  const StarDisplay({Key key, this.value = 0, this.tamanio})
      : assert(value != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < value ? Icons.star : Icons.star_border,
          size: tamanio,
        );
      }),
    );
  }
}
