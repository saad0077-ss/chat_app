<div align="center">

# 🌌 Nebula Chat

**A Modern, Animated, Offline-First Real-Time Chat Application**  
*Built with Flutter, BLoC State Management, SQLite Local Store, Cloud Firestore & Clean Architecture.*

[![Flutter](https://img.shields.io/badge/Flutter-3.10+-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![BLoC](https://img.shields.io/badge/State_Management-BLoC_9.x-blueviolet?style=for-the-badge&logo=bloc&logoColor=white)](https://bloclibrary.dev)
[![SQLite](https://img.shields.io/badge/Local_Storage-sqflite-003B57?style=for-the-badge&logo=sqlite&logoColor=white)](https://pub.dev/packages/sqflite)
[![Firebase](https://img.shields.io/badge/Backend-Cloud_Firestore-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com)
[![Architecture](https://img.shields.io/badge/Architecture-Clean_Architecture-4CAF50?style=for-the-badge)](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](LICENSE)

<br/>

<p align="center">
  <a href="#-key-features">Key Features</a> •
  <a href="#-architecture--data-flow">Architecture</a> •
  <a href="#-tech-stack">Tech Stack</a> •
  <a href="#-project-structure">Project Structure</a> •
  <a href="#-branching-strategy">Branch Strategy</a> •
  <a href="#-getting-started">Getting Started</a>
</p>

</div>

---

## ✨ Overview

**Nebula Chat** is a high-performance messaging client designed with an **offline-first relational message store (`sqflite`)**, real-time cloud synchronization via **Cloud Firestore**, and an immersive **Nebula Glass** design system.

Moving away from standard messenger clones, Nebula Chat introduces custom glassmorphism, animated transitions, pulsating online status indicators, and an optimistic UI update pipeline that delivers messages with zero perceived latency.

---

## 🚀 Key Features

### ⚡ Offline-First Local Store (`sqflite`)
- **Instant Message Caching**: All incoming and outgoing messages are persisted in a local relational SQLite database before touching the network.
- **Optimistic UI Updates**: Messages appear in the chat instantly with a `pendingSync` indicator and update to `synced` in the background once pushed to Firestore.
- **Offline Reading & Drafting**: Complete conversation histories remain accessible with zero network connectivity.

### 🎨 "Nebula Glass" Design System
- **Midnight Obsidian Aesthetic**: Sleek dark space theme (`#090A10`) accented with Electric Violet (`#7C3AED`) and Neon Cyan (`#06B6D4`).
- **Frosted Glassmorphism**: Translucent floating bottom navigation, blurred chat input bars, and subtle borders.
- **Micro-Animations**: Scale-in message bubbles, smooth entrance slides, and pulsating ambient glow rings around active user avatars.

### 🏛️ Strict Clean Architecture
- **Complete Decoupling**: Separation across **Domain** (pure business rules & entities), **Data** (SQLite + Firestore repositories), and **Presentation** (BLoC + Modular Widgets).
- **Single-Responsibility Widgets**: Every UI component (speech bubbles, avatars, input fields, sync ticks, navigation tabs) is maintained in its own dedicated file.

---

## 🏛️ Architecture & Data Flow

Nebula Chat implements an offline-first repository pattern where the local SQLite database acts as the single source of truth for the presentation layer:

```mermaid
flowchart TD
    subgraph UI ["Presentation Layer (Flutter + BLoC)"]
        ChatScreen["ModernChatRoomPage"]
        ChatBloc["ChatRoomBloc"]
    end

    subgraph Domain ["Domain Layer (Business Logic)"]
        UseCase["SendOfflineMessageUseCase"]
        Entity["ChatMessageEntity"]
    end

    subgraph Data ["Data Layer (Offline-First Repo)"]
        Repo["ChatRepositoryImpl"]
        LocalDS["ChatLocalDataSource (SQLite)"]
        RemoteDS["ChatRemoteDataSource (Firestore)"]
    end

    ChatScreen -->|"User sends text"| ChatBloc
    ChatBloc -->|"Dispatches event"| UseCase
    UseCase --> Repo
    Repo -->|"1. Write to SQLite"| LocalDS
    LocalDS -->|"2. Stream updated DB"| ChatBloc
    ChatBloc -->|"3. Instant render [pendingSync]"| ChatScreen
    Repo -.->|"4. Background cloud sync"| RemoteDS
    RemoteDS -.->|"5. On cloud ack -> mark synced"| LocalDS
