import 'dart:convert';

import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductosProviders {
  List<Map> productos = [
    {
      'clave_producto': '100',
      'nombre': "Texan Burger",
      'precio': '0',
      'familia_prod': '30',
      'imagen':
          'https://menu.applebees.com.mx/wp-content/uploads/2020/06/Texan-burger-e1592004708758.jpg',
      'marca': '',
      'descripcion':
          'Hamburguesa con trocitos de brisket de res BBQ, cebolla, chile jalapeño fresco, queso Cheddar blanco y nuestra salsa especial de la casa.'
    },
    {
      'clave_producto': '102',
      'nombre': "Cowboy Burger",
      'precio': '0',
      'familia_prod': '30',
      'imagen':
          'https://menu.applebees.com.mx/wp-content/uploads/2020/06/Cowboy-Burger.jpg',
      'marca': '',
      'descripcion':
          'Hamburguesa cubierta con crujientes tiras de cebolla, queso Cheddar blanco, tocino ahumado, lechuga, tomate, cebolla, pepinillos y salsa BBQ.'
    },
    {
      'clave_producto': '103',
      'nombre': "Avocado Burger",
      'precio': '0',
      'familia_prod': '30',
      'imagen':
          'https://menu.applebees.com.mx/wp-content/uploads/2020/06/Avocado-Burger.jpg',
      'marca': '',
      'descripcion':
          'Hamburguesa cubierta con queso suizo, tocino y aguacate. Servida con mayonesa de tomates secos.'
    },
    {
      'clave_producto': '104',
      'nombre': "Applebee's Riblets",
      'precio': '0',
      'familia_prod': '40',
      'imagen':
          'https://menu.applebees.com.mx/wp-content/uploads/2020/06/Riblets-Smaller-Portion.jpg',
      'marca': '',
      'descripcion':
          'Costillas de cerdo ahumadas y bañadas con la salsa de tu elección. Se sirven con papas fritas y elote. Porción Regular y Riblets Basket (Half size)'
    },
    {
      'clave_producto': '105',
      'nombre': "Double-Glazed Ribs",
      'precio': '0',
      'familia_prod': '302010',
      'imagen':
          'https://menu.applebees.com.mx/wp-content/uploads/2020/06/Double-glazed-Ribs.jpg',
      'marca': '',
      'descripcion':
          'Costillar de cerdo asado a la parrilla, bañado con salsa de tu elección. Se sirven con papas fritas y elote. Porción Regular y Medio Costillar'
    },
    {
      'clave_producto': '106',
      'nombre': "Shrimp'N Parmesan Steak",
      'precio': '0',
      'familia_prod': '70',
      'imagen':
          'https://menu.applebees.com.mx/wp-content/uploads/2020/06/Shrimp-Parmesan-Steak-New-Photo.jpg',
      'marca': '',
      'descripcion':
          'Tierno corte acompañado de suculentos camarones y quesos italianos. Se sirve con selección de 2 guarniciones.'
    },
    {
      'clave_producto': '107',
      'nombre': "House Steak",
      'precio': '261.95',
      'familia_prod': '70',
      'imagen':
          'https://menu.applebees.com.mx/wp-content/uploads/2020/06/House-Steak.jpg',
      'marca': '',
      'descripcion': ''
    },
    {
      'clave_producto': '108',
      'nombre': "Bourbon Street Steak",
      'precio': '0',
      'familia_prod': '70',
      'imagen':
          'https://menu.applebees.com.mx/wp-content/uploads/2020/06/Bourbon-Street-Steak.jpg',
      'marca': '',
      'descripcion': ''
    },
    {
      'clave_producto': '109',
      'nombre': 'Buffalo Salad',
      'precio': '0',
      'familia_prod': '90',
      'imagen':
          'https://menu.applebees.com.mx/wp-content/uploads/2020/06/Buffalo-Salad.jpg',
      'marca': '',
      'descripcion': ''
    },
    {
      'clave_producto': '110',
      'nombre': "Oriental Chicken Salad",
      'precio': '0',
      'familia_prod': '90',
      'imagen':
          'https://menu.applebees.com.mx/wp-content/uploads/2020/06/Oriental-Chicken-Salad.jpg',
      'marca': '',
      'descripcion': ''
    },
    {
      'clave_producto': '111',
      'nombre': "BREWTUS",
      'precio': '0',
      'familia_prod': '8010',
      'imagen':
          'https://applebees.com.mx/wp-content/uploads/2020/05/BudLight_Brewtusv1a_HR.jpg',
      'marca': '',
      'descripcion': ''
    },
    {
      'clave_producto': '112',
      'nombre': "Perfect Cosmo",
      'precio': '0',
      'familia_prod': '8010',
      'imagen':
          'https://applebees.com.mx/wp-content/uploads/2020/05/PerfectCosmo.jpg',
      'marca': '',
      'descripcion': ''
    },
    {
      'clave_producto': '113',
      'nombre': "Perfect Margarita",
      'precio': '0',
      'familia_prod': '8010',
      'imagen':
          'https://applebees.com.mx/wp-content/uploads/2020/05/PerfectMargarita.jpg',
      'marca': '',
      'descripcion': ''
    },
  ];

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List items;

    if (prefs.getString('carrito') == null) {
      items = [];
      items.add(producto);
    } else {
      items = jsonDecode(prefs.getString('carrito'));
      var index =
          items.indexWhere((element) => element['id'] == producto['id']);
      if (index == -1)
        items.add(producto);
      else {
        items[index]['cantidad'] += producto['cantidad'];
      }
    }
    prefs.setString('carrito', jsonEncode(items));
  }

  removeProductoCarrito(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var carrito = prefs.getString('carrito');
    List items;
    if (carrito != null) {
      items = jsonDecode(carrito);
      items.removeWhere((element) => element['id'] == id);

      prefs.setString('carrito', jsonEncode(items));
    }
  }

  Future<Map> sizeCarrito() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var carrito = prefs.getString('carrito');
    List items;
    Map<String, dynamic> resultado = {'cantidad': 0, 'total': 0};

    if (items != null) {
      items = jsonDecode(carrito);
      items.forEach((element) {
        resultado['cantidad'] += element['cantidad'];
        resultado['total'] += (element['cantidad'] * element['precio']);
      });
    }
    return resultado;
  }

  Future<List> getProductosCarrito() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var carrito = prefs.getString('carrito');
    List items;

    if (carrito != null) {
      items = jsonDecode(carrito);
    } else {
      items = [];
    }

    return items;
  }

  actualizarCarrito(List productos) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    prefs.setString('carrito', jsonEncode(productos));
  }
}
