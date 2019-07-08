import 'package:firebase_storage/firebase_storage.dart';

import 'app.dart';

final storage = FirebaseStorage(
    app: app, storageBucket: 'gs://mixtaprint-bdece.appspot.com');
