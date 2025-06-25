# Proto Contracts - SSO Authentication Service

Этот репозиторий содержит Protocol Buffer контракты для сервиса аутентификации SSO (Single Sign-On).

## 📁 Структура проекта

```
protos/
├── go.mod                 # Go модуль с зависимостями
├── go.sum                 # Хеши зависимостей
├── Makefile              # Команды для генерации кода
├── README.md             # Документация
└── protos/
    └── sso/
        ├── sso.proto     # Основной proto файл
        ├── sso.pb.go     # Сгенерированный Go код
        └── sso_grpc.pb.go # Сгенерированный gRPC код
```

## 🔧 Сервис Auth

Сервис предоставляет API для аутентификации пользователей с поддержкой регистрации, входа и проверки административных прав.

### Методы API

#### 1. Register

Регистрирует нового пользователя в системе.

**Request:**

```protobuf
message RegisterRequest {
    string email = 1;      // Email пользователя
    string password = 2;   // Пароль пользователя
}
```

**Response:**

```protobuf
message RegisterResponse {
    int64 id = 1;          // ID зарегистрированного пользователя
}
```

#### 2. Login

Выполняет аутентификацию пользователя и возвращает JWT токен.

**Request:**

```protobuf
message LoginRequest {
    string email = 1;      // Email пользователя
    string password = 2;   // Пароль пользователя
    int32 app_id = 3;      // ID приложения
}
```

**Response:**

```protobuf
message LoginResponse {
    string token = 1;      // JWT токен для аутентификации
}
```

#### 3. IsAdmin

Проверяет, является ли пользователь администратором.

**Request:**

```protobuf
message IsAdminRequest {
    string user_id = 1;    // ID пользователя
}
```

**Response:**

```protobuf
message IsAdminResponse {
    bool is_admin = 1;     // Статус администратора
}
```

## 🚀 Установка и настройка

### Предварительные требования

- Go 1.24.4 или выше
- Protocol Buffers Compiler (protoc)
- Make (для использования Makefile)

### Установка зависимостей

```bash
# Установка protobuf инструментов
make proto-deps
```

### Генерация кода

```bash
# Генерация Go кода из proto файлов
make proto
```

Эта команда создаст:

- `protos/sso/sso.pb.go` - Go структуры для сообщений
- `protos/sso/sso_grpc.pb.go` - Go интерфейсы и клиенты для gRPC

## 📦 Зависимости

Основные зависимости проекта:

- `google.golang.org/grpc` v1.73.0 - gRPC фреймворк
- `google.golang.org/protobuf` v1.36.6 - Protocol Buffers

## 🔄 Использование

### Импорт в Go проекте

```go
import (
    "github.com/vyantik/protos-go/protos/sso"
    "google.golang.org/grpc"
)

// Создание gRPC клиента
conn, err := grpc.Dial("localhost:50051", grpc.WithInsecure())
if err != nil {
    log.Fatal(err)
}
defer conn.Close()

client := sso.NewAuthClient(conn)

// Пример регистрации пользователя
resp, err := client.Register(context.Background(), &sso.RegisterRequest{
    Email:    "user@example.com",
    Password: "password123",
})
```

### Реализация сервера

```go
type authServer struct {
    sso.UnimplementedAuthServer
}

func (s *authServer) Register(ctx context.Context, req *sso.RegisterRequest) (*sso.RegisterResponse, error) {
    // Логика регистрации
    return &sso.RegisterResponse{Id: 123}, nil
}

func (s *authServer) Login(ctx context.Context, req *sso.LoginRequest) (*sso.LoginResponse, error) {
    // Логика входа
    return &sso.LoginResponse{Token: "jwt_token_here"}, nil
}

func (s *authServer) IsAdmin(ctx context.Context, req *sso.IsAdminRequest) (*sso.IsAdminResponse, error) {
    // Логика проверки администратора
    return &sso.IsAdminResponse{IsAdmin: false}, nil
}
```

## 🛠️ Разработка

### Добавление новых методов

1. Отредактируйте `protos/sso/sso.proto`
2. Добавьте новые методы в сервис `Auth`
3. Определите соответствующие сообщения
4. Запустите `make proto` для генерации кода

### Версионирование

При внесении изменений в proto контракты:

- Обновляйте версию в `go.mod` при необходимости
- Документируйте breaking changes
- Используйте semantic versioning

## 📝 Лицензия

Этот проект распространяется под лицензией MIT.

## 🤝 Вклад в проект

1. Форкните репозиторий
2. Создайте ветку для новой функции
3. Внесите изменения
4. Добавьте тесты
5. Создайте Pull Request

## 📞 Поддержка

По вопросам и предложениям создавайте Issues в репозитории.
