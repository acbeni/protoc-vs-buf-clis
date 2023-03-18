out_folder:="generated"

.PHONY: clean
clean:
	rm -rf $(out_folder)
	mkdir -p $(out_folder)

.PHONY: install-proto-dep
install-proto-dep:
	brew install protobuf@21
	go get google.golang.org/protobuf/cmd/protoc-gen-go
	go get google.golang.org/grpc/cmd/protoc-gen-go-grpc
	go install google.golang.org/protobuf/cmd/protoc-gen-go
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc

.PHONY: generate-protoc
generate-protoc: clean
	protoc --go_out=$(out_folder) \
	--go_opt=paths=source_relative \
	--go-grpc_out=$(out_folder) \
	--go-grpc_opt=paths=source_relative \
	-I . api/profile/v1/profile.proto

.PHONY: install-buf
install-buf:
	brew install buf

.PHONY: generate-buf
generate-buf:
	buf generate