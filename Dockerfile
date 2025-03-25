# syntax=docker/dockerfile:1
FROM golang:1.24-alpine AS builder
LABEL authors="user"

RUN apk update
RUN apk add --upgrade --no-cache ca-certificates && update-ca-certificates
RUN adduser -D -g '' www
WORKDIR /app
COPY go.mod go.sum ./

RUN go mod download

COPY . ./

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s" -o /app/bin.elf
FROM scratch
WORKDIR /app
COPY --from=builder /etc/ssl/certs/ /etc/ssl/certs/
COPY --from=builder /app/bin.elf /app/bin
COPY --from=builder /etc/passwd /etc/passwd

USER www
ENTRYPOINT ["/app/bin"]
