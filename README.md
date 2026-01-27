# Memoria (Flutter client)

## Features
- Clean Architecture (data/domain/presentation)
- BLoC
- GetIt DI
- Dio networking
- CachedNetworkImage
- Responsive UI helpers
- Animations (Material motion)
- Local history (Hive) + offline local copies of enhanced/compare images

## Run
```bash
flutter pub get
flutter run
```

## API
Base URL: https://image-restoration-backend-1.onrender.com
- POST /upload (multipart form-data: file)
- GET  /download/{imageId} (returns image bytes)
- GET  /compare/{imageId}  (returns image bytes)
