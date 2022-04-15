# Mobile Attendance
Mobile Attendance merupakan sebuah aplikasi yang dapat melakukan absensi bedasarkan lokasi pengguna saat ini. Dengan menggunakan geolocator, aplikasi ini dapat menentukan jarak antara pengguna dan HQ. Jika jarak tersebut >= 50 meter, maka absensi akan ditolak. Jika jarak tersebut < 50 meter, maka absensi pengguna akan diterima oleh sistem. Seluruh absensi baik yang diterima maupun ditolak akan disimpan kedalam sistem dan dapat dilihat melalui halaman history.

Perlu dicatat juga bahwa aplikasi ini mempunyai fitur HQ dan juga fitur pegawai. Dimana fitur HQ berupa:
- Change HQ Location
- All History

Sedangkan fitur pegawai berupa:
- Submit Attendance
- Specific User History

## User Documentation
![user-doc-1](assets/images/user-doc-1.png?raw=true "Title")
![user-doc-2](assets/images/user-doc-2.png?raw=true "Title")
![user-doc-3](assets/images/user-doc-3.png?raw=true "Title")

## Technical Documentation
Coming ASAP!

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
- Sign-in untuk user
