# Mobile Attendance
Mobile Attendance merupakan 

## User Documentation

## Dependencies
- geolocator: https://pub.dev/packages/geolocator
- animated_bottom_navigation_bar: https://pub.dev/packages/animated_bottom_navigation_bar
- google_maps_flutter: https://pub.dev/packages/google_maps_flutter
- cloud_firestore: https://pub.dev/packages/cloud_firestore
- firebase_core: https://pub.dev/packages/firebase_core
- fluttertoast: https://pub.dev/packages/fluttertoast
- intl: https://pub.dev/packages/intl
- loading_animation_widget: https://pub.dev/packages/loading_animation_widget

## Future Development
- Seperate Worker and HQ app
- Add feature to scan QR before being able to submit attendance. Why? Karena bisa aja dia di gedung yang sama tetapi di lantai lain (di cafe), atau di gedung sebelah yang berjarak < 50m. QR akan memaksa karyawan untuk scan di lantai kerja mereka. Setiap hari QR harus berganti agar tidak bisa dipalsukan
- Time limit. Contoh: Hanya menerima pukul 8.00-9.00, sisanya terhitung telat/absen
