FROM golang:1.24.1-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o server ./cmd/server

FROM alpine:latest

WORKDIR /root/
COPY --from=builder /app/server .
COPY --from=builder /app/.env .env

EXPOSE 8080

CMD ["./server"]