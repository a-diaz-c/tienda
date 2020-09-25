import 'package:localstorage/localstorage.dart';

class ProductosProviders {
  List<Map> productos = [
    {
      'clave_producto': '100',
      'nombre': "Texan Burger",
      'precio': '0',
      'familia_prod': '30',
      'imagen':
          'https://menu.applebees.com.mx/wp-content/uploads/2020/06/Texan-burger-e1592004708758.jpg',
      'marca': ''
    },
    {
      'clave_producto': '102',
      'nombre': "Cowboy Burger",
      'precio': '0',
      'familia_prod': '30',
      'imagen':
          'https://menu.applebees.com.mx/wp-content/uploads/2020/06/Cowboy-Burger.jpg',
      'marca': ''
    },
    {
      'clave_producto': '103',
      'nombre': "Avocado Burger",
      'precio': '0',
      'familia_prod': '30',
      'imagen':
          'https://menu.applebees.com.mx/wp-content/uploads/2020/06/Avocado-Burger.jpg',
      'marca': ''
    },
    {
      'clave_producto': '104',
      'nombre': "Applebee's Riblets",
      'precio': '0',
      'familia_prod': '40',
      'imagen':
          'https://menu.applebees.com.mx/wp-content/uploads/2020/06/Riblets-Smaller-Portion.jpg',
      'marca': ''
    },
    {
      'clave_producto': '105',
      'nombre': "Double-Glazed Ribs",
      'precio': '0',
      'familia_prod': '302010',
      'imagen':
          'https://menu.applebees.com.mx/wp-content/uploads/2020/06/Double-glazed-Ribs.jpg',
      'marca': ''
    },
    {
      'clave_producto': '106',
      'nombre': "Shrimp'N Parmesan Steak",
      'precio': '0',
      'familia_prod': '70',
      'imagen':
          'https://menu.applebees.com.mx/wp-content/uploads/2020/06/Shrimp-Parmesan-Steak-New-Photo.jpg',
      'marca': ''
    },
    {
      'clave_producto': '107',
      'nombre': "House Steak",
      'precio': '261.95',
      'familia_prod': '70',
      'imagen':
          'https://menu.applebees.com.mx/wp-content/uploads/2020/06/House-Steak.jpg',
      'marca': ''
    },
    {
      'clave_producto': '108',
      'nombre': "Bourbon Street Steak",
      'precio': '0',
      'familia_prod': '70',
      'imagen':
          'https://menu.applebees.com.mx/wp-content/uploads/2020/06/Bourbon-Street-Steak.jpg',
      'marca': ''
    },
    {
      'clave_producto': '109',
      'nombre': 'Buffalo Salad',
      'precio': '0',
      'familia_prod': '90',
      'imagen':
          'https://menu.applebees.com.mx/wp-content/uploads/2020/06/Buffalo-Salad.jpg',
      'marca': ''
    },
    {
      'clave_producto': '110',
      'nombre': "Oriental Chicken Salad",
      'precio': '0',
      'familia_prod': '90',
      'imagen':
          'https://menu.applebees.com.mx/wp-content/uploads/2020/06/Oriental-Chicken-Salad.jpg',
      'marca': ''
    },
    {
      'clave_producto': '111',
      'nombre': "BREWTUS",
      'precio': '0',
      'familia_prod': '8010',
      'imagen':
          'https://applebees.com.mx/wp-content/uploads/2020/05/BudLight_Brewtusv1a_HR.jpg',
      'marca': ''
    },
    {
      'clave_producto': '112',
      'nombre': "Perfect Cosmo",
      'precio': '0',
      'familia_prod': '8010',
      'imagen':
          'https://applebees.com.mx/wp-content/uploads/2020/05/PerfectCosmo.jpg',
      'marca': ''
    },
    {
      'clave_producto': '113',
      'nombre': "Perfect Margarita",
      'precio': '0',
      'familia_prod': '8010',
      'imagen':
          'https://applebees.com.mx/wp-content/uploads/2020/05/PerfectMargarita.jpg',
      'marca': ''
    },
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
