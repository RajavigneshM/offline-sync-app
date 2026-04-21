# 📱 Offline-First Sync Queue (Flutter)

## 🚀 Overview

This project demonstrates an **offline-first architecture** in Flutter, focusing on reliable data synchronization using a persistent queue.

The application allows users to:

* View notes instantly from local cache
* Add notes even when offline
* Like/unlike notes offline
* Automatically sync all actions when connectivity is restored

The system ensures **eventual consistency while prioritizing local responsiveness**.

---

## 🏗️ Architecture

```text
UI (Flutter)
   ↓
BLoC (State Management)
   ↓
Local Database (Hive)
   ↓
Sync Queue (Persistent)
   ↓
Sync Service
   ↓
Backend (Firebase Firestore / Mock API)
```

### Key Components:

* **Hive** → Local storage for notes and sync queue
* **BLoC** → Manages UI state and business logic
* **Sync Queue** → Stores offline actions reliably
* **Sync Service** → Handles retry and syncing logic
* **Firebase Firestore** → Backend (optional / mock supported)

---

## 🔄 Data Flow

### 📥 Read Flow (Local-first)

1. Load notes from local database (Hive)
2. Display instantly to user
3. Fetch latest data from backend (if online)
4. Update local cache

---

### 📤 Write Flow (Offline-first)

1. User performs action (Add / Like)
2. Data is saved locally immediately
3. Action is added to sync queue
4. Sync service processes queue when online

---

## 🔑 Idempotency Strategy

To prevent duplicate operations during retries:

* Each sync action has a unique **idempotency key (UUID)**
* Notes are stored in backend using **consistent document IDs**
* Repeated sync attempts overwrite existing data instead of duplicating

✅ Ensures safe retries
✅ Prevents duplicate entries

---

## ⚔️ Conflict Resolution

**Strategy Used:** Last Write Wins (LWW)

* Based on `updatedAt` timestamp
* The most recent update overwrites previous versions

### Trade-offs:

* ✔ Simple and predictable
* ❌ May overwrite concurrent updates

---

## 🔁 Retry Mechanism

* Each failed sync is retried **once**
* Basic delay (2 seconds) before retry
* Failed operations are logged

---

## 💾 Durability

* Sync queue is stored in **Hive**
* Survives app restarts
* Ensures no data loss even if app is killed

---

## 📊 Observability

The app logs key events:

* Queue size
* Sync success
* Sync failure
* Retry attempts

### Example Logs:

```text
QUEUE SIZE: 2
🔁 RETRYING: action_123
✅ SYNC SUCCESS: action_123
QUEUE SIZE: 0
```

---

## 🧪 Verification Scenarios

### ✅ Scenario 1: Offline Add Note

* Disable internet
* Add a note
* Restart the app
* Enable internet
* Observe successful sync

---

### ✅ Scenario 2: Offline Like Action

* Like/unlike a note while offline
* Local UI updates instantly
* Sync happens when online

---

### ✅ Scenario 3: Retry Logic

* Simulated network failure
* Retry is triggered automatically
* No duplicate entries created

---

## ⭐ Bonus Features

### ⏱️ TTL (Time-To-Live) for Cache

* Data refresh triggered after a fixed duration
* Avoids unnecessary API calls

### 🧪 Unit Test (Idempotency)

* Ensures same operation does not create duplicates

---

## ⚠️ Limitations

* No advanced conflict resolution (merge strategy not implemented)
* Retry logic is basic (no exponential backoff)
* No background sync service (runs only when app is active)
* Firestore authentication not implemented (used open rules for simplicity)

---

## 🚀 Future Improvements

* Implement exponential backoff retry strategy
* Add background sync using WorkManager
* Introduce conflict merging strategies
* Add batching for sync operations
* Add real-time connectivity listener for auto-sync trigger

---

## 🛠️ Setup Instructions

### 1. Clone Repository

```bash
git clone <your-repo-link>
cd offline_sync_app
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Run App

```bash
flutter run
```

---

## 📂 Project Structure

```text
lib/
 ├── models/
 ├── services/
 ├── bloc/
 ├── ui/
 └── main.dart
```

---

## 🤖 AI Usage

AI tools were used to:

* Explore offline-first architecture patterns
* Design sync queue structure
* Validate retry and idempotency strategies

All outputs were **reviewed, modified, and validated manually**.

See `AI_PROMPT_LOG.md` for full details.

---

## 📸 Verification Evidence

Screenshots and logs demonstrating:

* Offline actions
* Queue persistence
* Retry logic
* Sync success

Available in `/evidence/` folder.

---

## 📌 Conclusion

This project demonstrates a **robust offline-first system** with:

* Reliable sync queue
* Safe retry handling
* Idempotent operations
* Persistent local storage

The system is designed with a **production mindset**, ensuring data integrity and user experience even in unreliable network conditions.

---
