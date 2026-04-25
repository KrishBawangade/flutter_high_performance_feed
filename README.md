# 🚀 High Performance Feed (Flutter)

A highly optimized infinite-scrolling social feed built using **Flutter + Riverpod + Supabase**, focusing on UI performance, memory efficiency, and optimistic state management.

---

## 📱 Demo

> 🔗 https://drive.google.com/drive/folders/1_Dxc0kssvl3b3qzL6qL1HbhrrSoew-px

---

## 🛠 Tech Stack

| Layer | Technology |
|---|---|
| UI Framework | Flutter |
| State Management | Riverpod (StateNotifier) |
| Backend | Supabase (REST + RPC + Storage) |
| Image Loading | CachedNetworkImage + ResizeImage |

---

## 📂 Project Structure

```
lib/
 ┣ core/
 ┃ ┣ constants/
 ┃ ┣ env/
 ┃ ┣ router/
 ┃ ┣ theme/
 ┃ ┗ utils/
 ┣ features/
 ┃ ┗ feed/
 ┃    ┣ data/
 ┃    ┃ ┣ datasource/
 ┃    ┃ ┣ models/
 ┃    ┃ ┗ repository/
 ┃    ┗ presentation/
 ┃       ┣ notifier/
 ┃       ┣ pages/
 ┃       ┣ providers/
 ┃       ┗ widgets/
 ┣ shared/
 ┃ ┗ widgets/
```

---

## 🧠 Architecture

- **Clean Architecture** (Feature-first + layered separation)
- Clear separation of concerns:
  - `Data layer` → API calls & models
  - `Presentation layer` → UI + state management
- Scalable and maintainable structure

---

## ✨ Features

### 📜 Infinite Feed
- REST-based pagination (10 items per request)
- Pull-to-refresh support
- Efficient scroll handling via `ScrollController`

### ❤️ Optimistic Like System
- Instant UI update on like/unlike
- Background RPC call (`toggle_like`)
- Debounced requests to prevent spam clicking
- Automatic UI revert on failure (offline handling)

### 🖼️ Tiered Image Loading

| Tier | Field | Usage |
|---|---|---|
| Thumbnail | `media_thumb_url` | Feed view |
| Mobile | `media_mobile_url` | Detail page |
| High-res | `media_raw_url` | On-demand |

- Prevents unnecessary data usage
- Improves loading performance

### 🎬 Hero Animation
- Smooth transition between feed and detail page
- Shared `ImageProvider` to prevent flicker
- Progressive image loading (thumbnail → full)

---

## ⚡ Performance Optimizations

### 🎨 GPU Optimization
- Identified `ClipRRect` as a major rasterization bottleneck
- Removed full-card clipping to reduce GPU load
- Limited clipping to required areas (image only)
- Optimized `BoxShadow` to balance UI and performance
- Used `RepaintBoundary` to isolate repaint regions

### 🧠 State Optimization
- Riverpod with selective rebuilds (`select`)
- Avoided unnecessary widget rebuilds
- Efficient state mutation for optimistic UI

### 🖼️ Image Optimization
- `ResizeImage` with calculated `cacheWidth`
- Decoded image size matches display size
- Reduced memory usage (OOM prevention)
- Cached `ImageProvider` using `Map + putIfAbsent`

### 📜 List Rendering Optimization
- Tuned `cacheExtent` for better scroll performance
- Reduced offscreen rendering cost

---

## 🧪 Performance Verification

- Used **Flutter DevTools** (Profile Mode)
- Analyzed:
  - Raster thread performance
  - Frame rendering timeline
- Identified and fixed continuous raster jank caused by excessive clipping
- Achieved smooth scrolling under normal usage

---

## ⚠️ Edge Case Handling

### 🔁 Spam Click Handling
- Debounced like requests
- Prevented inconsistent database state

### 📡 Offline Handling
- Optimistic UI updates without network
- Automatic revert on failure
- Error feedback via `SnackBar`

### ⚡ Rapid Scrolling (Jank Test)
- Reduced GPU workload by minimizing clipping and repaint regions
- Maintained smooth UX under stress

---

## 📦 Build Instructions

```bash
flutter pub get
flutter run --profile
```

### 🔐 Release Build (Obfuscated)

```bash
flutter build apk --release --obfuscate --split-debug-info=build/debug-info
```

---

## 🧠 Key Learnings

- `ClipRRect` significantly impacts GPU performance in scrollable lists
- Minimizing repaint regions is critical for smooth scrolling
- Proper image decoding size prevents memory issues
- Flutter DevTools is essential for identifying real bottlenecks

---

## 📌 Conclusion

This project demonstrates a balance between:

- ✅ High-quality UI design
- ✅ Efficient memory usage
- ✅ Smooth scrolling performance
- ✅ Responsive and reliable interactions

---

## 🙌 Final Note

> The app has been optimized based on real profiling using Flutter DevTools, ensuring **practical performance improvements** rather than theoretical optimizations.
