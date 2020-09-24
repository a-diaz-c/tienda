import 'package:localstorage/localstorage.dart';

class ProductosProviders {
  List<Map> productos = [
    {
      'clave_producto': '100',
      'nombre': "DEWALT Lijadora Roto-Orbital 5 pulgadas",
      'precio': '1419.00',
      'familia_prod': '302020',
      'imagen':
          'https://images-na.ssl-images-amazon.com/images/I/71RznGesePL._AC_SL1399_.jpg',
      'marca': 'Wal front'
    },
    {
      'clave_producto': '102',
      'nombre':
          "Bestgle Propósito de Mufti Eje flexible para herramienta rotativa Taladro flexible Troqueladora Extensión del eje eléctrico Herramienta rotativa Accesorio Accesorio Accesorio de llave Chuck 3.175mm",
      'precio': '430',
      'familia_prod': '302020',
      'imagen':
          'https://images-na.ssl-images-amazon.com/images/I/51KszPCXBQL._AC_SL1000_.jpg',
      'marca': 'Sonoff'
    },
    {
      'clave_producto': '103',
      'nombre': "Black + Decker BDCMTJS - Accesorio para sierra de calar",
      'precio': '430.00',
      'familia_prod': '302020',
      'imagen':
          'https://images-na.ssl-images-amazon.com/images/I/7126oDJhzZL._AC_SL1500_.jpg',
      'marca': 'Black & Decker'
    },
    {
      'clave_producto': '104',
      'nombre': "Hidrolavadora Eléctrica, 1800 Psi, Pretul Hila-1800P",
      'precio': '1735.00',
      'familia_prod': '302020',
      'imagen':
          'https://images-na.ssl-images-amazon.com/images/I/71bk35sq65L._AC_SL1500_.jpg',
      'marca': 'Koblenz'
    },
    {
      'clave_producto': '105',
      'nombre': "Set de pruebas eléctricas Klein Tools 69149",
      'precio': '1097.00',
      'familia_prod': '302010',
      'imagen':
          'https://images-na.ssl-images-amazon.com/images/I/61Is%2Bb3s-PL._AC_SL1000_.jpg',
      'marca': 'Klein Tools'
    },
    {
      'clave_producto': '106',
      'nombre': "Sonoff Basic Interruptor Inteligente WiFi",
      'precio': '2717.00',
      'familia_prod': '302010',
      'imagen':
          'https://images-na.ssl-images-amazon.com/images/I/51WSJq7fSoL._AC_SL1000_.jpg',
      'marca': 'Sonoff'
    },
    {
      'clave_producto': '107',
      'nombre':
          "Pyle PCO850 Acondicionador Eléctrico de 15 A, con Regleta para Montaje en Rack y Protector de Picos con 9 Tomacorrientes",
      'precio': '261.95',
      'familia_prod': '302010',
      'imagen':
          'https://images-na.ssl-images-amazon.com/images/I/51E%2BuIQJfzL._AC_SL1000_.jpg',
      'marca': 'Pyle'
    },
    {
      'clave_producto': '108',
      'nombre':
          "Koblenz NBKKBZ330 No-Break 5216 USB/R - 520 Va, 240 W, Negro, para Oficina",
      'precio': '967.00',
      'familia_prod': '302020',
      'imagen':
          'https://images-na.ssl-images-amazon.com/images/I/81IaAPXDYDL._AC_SL1500_.jpg',
      'marca': 'Koblenz'
    },
    {
      'clave_producto': '109',
      'nombre':
          "Motor de engranaje, Walfront AC 220 V 200 W M6200-502 CW/CCW motor reductor de alta velocidad de torque reducir motor eléctrico con regulador de caja de cambios",
      'precio': '8208.85',
      'familia_prod': '302020',
      'imagen':
          'https://images-na.ssl-images-amazon.com/images/I/51ndoEOn9XL._AC_SL1001_.jpg',
      'marca': 'Wal front'
    },
    {
      'clave_producto': '110',
      'nombre': "Wera 05056491001 Juego de Herramientas con 39 Piezas",
      'precio': '2140.34',
      'familia_prod': '302010',
      'imagen':
          'https://images-na.ssl-images-amazon.com/images/I/81aGRoTjhWL._SL1500_.jpg',
      'marca': 'Wal front'
    },
    {
      'clave_producto': '111',
      'nombre':
          "Vino Tinto Casa Madero 3V Cabernet Sauvignon Merlot Tempranillo - 750 ml",
      'precio': '389',
      'familia_prod': '2010',
      'imagen':
          'https://images-na.ssl-images-amazon.com/images/I/516AQ85fNhL._AC_SL1000_.jpg',
      'marca': 'Madero'
    },
    {
      'clave_producto': '112',
      'nombre': "Vino Tinto Woodbridge Robert Mondavi Merlot 750 ml",
      'precio': '205',
      'familia_prod': '2010',
      'imagen':
          'https://images-na.ssl-images-amazon.com/images/I/31TtJlrMbTL._AC_.jpg',
      'marca': 'Woodbridge'
    },
    {
      'clave_producto': '113',
      'nombre': "Vino Tinto Portillo Malbec 750 ml",
      'precio': '195',
      'familia_prod': '2010',
      'imagen':
          'https://images-na.ssl-images-amazon.com/images/I/31GCCR3Q5EL._AC_.jpg',
      'marca': 'Portillo'
    },
    {
      'clave_producto': '114',
      'nombre': "Coca-Cola Original, 24 Pack - 235 ml/lata",
      'precio': '194.36',
      'familia_prod': '2020',
      'imagen':
          'https://images-na.ssl-images-amazon.com/images/I/61Iv7I2CSmL._AC_SL1500_.jpg',
      'marca': 'Coca-Cola'
    },
    {
      'clave_producto': '115',
      'nombre': "Sidral Mundet, Sabor Manzana, 12 Pack - 235 ml/lata",
      'precio': '96.00',
      'familia_prod': '2020',
      'imagen':
          'https://images-na.ssl-images-amazon.com/images/I/51jKU3VRBFL._AC_SL1080_.jpg',
      'marca': 'Sidral Mundet'
    },
    {
      'clave_producto': '116',
      'nombre': "Coca-Cola Sin Azúcar, 12 Pack - 355 ml/lata",
      'precio': '154.00',
      'familia_prod': '2020',
      'imagen':
          'https://images-na.ssl-images-amazon.com/images/I/41l46ydVwzL._AC_.jpg',
      'marca': 'Coca-Cola'
    }
  ];
  final LocalStorage storage = new LocalStorage('user_app');

  List jsonProductos() {
    return productos;
  }

  buscarProducto(String id) {
    Map producto =
        productos.firstWhere((element) => element['clave_producto'] == id);
    return producto;
  }

  buscarFamilia(String familia) {
    var productosCategorias =
        productos.where((element) => element['familia_prod'] == familia);
    return productosCategorias.toList();
  }

  buscarPorMarcas(List marcas) {
    var productosMarcas = [];
    marcas.forEach((marca) {
      var busqueda = productos.where((element) => element['marca'] == marca);
      productosMarcas.addAll(busqueda);
    });
    return productosMarcas;
  }

  buscarPorMarcasFamilias(List marcas, String familia) {
    var productosMarcas = [];
    var productosFamilia = buscarFamilia(familia);
    print(productosFamilia);
    marcas.forEach((marca) {
      var busqueda =
          productosFamilia.where((element) => element['marca'] == marca);
      productosMarcas.addAll(busqueda);
    });
    return productosMarcas;
  }

  addProductoCarrito(Map<String, dynamic> producto) async {
    List items = storage.getItem('productos');

    if (items == null) {
      items = [];
      items.add(producto);
    } else {
      var index =
          items.indexWhere((element) => element['id'] == producto['id']);
      if (index == -1)
        items.add(producto);
      else {
        items[index]['cantidad'] += producto['cantidad'];
      }
    }
    storage.setItem('productos', items);
  }

  removeProductoCarrito(String id) {
    List items = storage.getItem('productos');

    print('Elminando $id');

    items.removeWhere((element) => element['id'] == id);

    storage.setItem('productos', items);
  }

  Map sizeCarrito() {
    List items = storage.getItem('productos');
    Map<String, dynamic> resultado = {'cantidad': 0, 'total': 0};

    if (items != null) {
      items.forEach((element) {
        resultado['cantidad'] += element['cantidad'];
        resultado['total'] += (element['cantidad'] * element['precio']);
      });
    }
    return resultado;
  }

  List getProductosCarrito() {
    List items = storage.getItem('productos');
    return items;
  }

  actualizarCarrito(List productos) async {
    await storage.clear();

    storage.setItem('productos', productos);
  }
}
