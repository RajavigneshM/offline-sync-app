# 🤖 AI Prompt Log

This document captures how AI tools were used during the development of this assignment, along with decisions taken after evaluating the responses.

---

## 1) Prompt

**"How to implement offline-first architecture in Flutter using Hive and Firebase?"**

* **Key Response Summary:**
  Suggested using local database for reads/writes and a background sync mechanism for server updates.

* **Decision:** Accepted

* **Why:**
  This aligns with standard offline-first architecture used in production systems.

---

## 2) Prompt

**"How to design a sync queue for offline writes in mobile apps?"**

* **Key Response Summary:**
  Recommended maintaining a queue of actions with payload and processing them sequentially when online.

* **Decision:** Accepted

* **Why:**
  Queue-based approach ensures durability and ordered execution of operations.

---

## 3) Prompt

**"How to ensure idempotency in API requests?"**

* **Key Response Summary:**
  Suggested using unique identifiers (UUIDs) and consistent resource IDs to avoid duplicate operations.

* **Decision:** Accepted

* **Why:**
  Prevents duplicate entries during retries and ensures safe reprocessing of requests.

---

## 4) Prompt

**"What are common retry strategies for network failures?"**

* **Key Response Summary:**
  Suggested exponential backoff with multiple retries.

* **Decision:** Modified

* **Why:**
  Simplified to a single retry with fixed delay (2 seconds) to match assignment scope and keep implementation minimal.

---

## 5) Prompt

**"Best conflict resolution strategies in offline-first systems?"**

* **Key Response Summary:**
  Provided options such as Last-Write-Wins (LWW) and merge-based strategies.

* **Decision:** Accepted (LWW)

* **Why:**
  Chosen for simplicity, predictability, and ease of implementation within limited time.

---

## 6) Prompt

**"How to persist queue data across app restarts in Flutter?"**

* **Key Response Summary:**
  Suggested using local storage like Hive or SQLite.

* **Decision:** Accepted

* **Why:**
  Ensures durability and prevents data loss if the app is terminated.

---

## 7) Prompt

**"How to detect internet connectivity in Flutter?"**

* **Key Response Summary:**
  Suggested using connectivity_plus package.

* **Decision:** Accepted

* **Why:**
  Lightweight and sufficient for triggering sync operations.

---

## 8) Prompt

**"How to simulate API failure for testing retry logic?"**

* **Key Response Summary:**
  Suggested throwing exceptions manually in API layer.

* **Decision:** Accepted

* **Why:**
  Enabled controlled testing of retry and idempotency behavior.

---

## 9) Prompt

**"How to implement TTL (time-to-live) for cached data?"**

* **Key Response Summary:**
  Suggested storing last fetch timestamp and validating freshness before fetching again.

* **Decision:** Accepted

* **Why:**
  Improves performance and avoids unnecessary network calls.

---

## 10) Prompt

**"Best practices for structuring Flutter apps with BLoC?"**

* **Key Response Summary:**
  Recommended separation into layers: UI, BLoC, Services, Models.

* **Decision:** Accepted

* **Why:**
  Improves maintainability and code readability.

---

## 🧠 Reflection on AI Usage

AI tools were used as a **guidance and acceleration tool**, not as a direct copy-paste solution.

* All suggestions were **reviewed and validated manually**
* Some responses were **modified** to fit assignment constraints
* Final implementation decisions were based on **understanding and reasoning**

---

## ⚖️ Key Takeaways

* AI helped speed up exploration of design patterns
* Critical thinking was applied before adopting solutions
* Trade-offs were consciously evaluated

---

## ✅ Conclusion

AI was used responsibly to:

* Explore architecture patterns
* Validate design decisions
* Improve development speed

However, the final system design and implementation were **carefully reviewed and adapted**, ensuring correctness and alignment with assignment requirements.

---
