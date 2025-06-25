PROJECT_NAME = $(notdir $(CURDIR))

# Определение операционной системы
ifeq ($(OS),Windows_NT)
        #Windows
        RM = del /F /Q
        BINARY_NAME = $(PROJECT_NAME).exe
        MKDIR = mkdir
        RMDIR = rmdir /S /Q
else
        #Linux/Mac
        RM = rm -f
        BINARY_NAME = $(PROJECT_NAME)
        MKDIR = mkdir -p
        RMDIR = rm -rf
endif

.PHONY: proto proto-deps

proto:
	@echo "Generating protobuf code..."
	@protoc --go_out=. --go_opt=paths=source_relative \
	--go-grpc_out=. --go-grpc_opt=paths=source_relative \
	protos/sso/sso.proto

# Команда для установки protobuf инструментов
proto-deps:
	@echo "Installing protobuf tools..."
	@go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	@go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest