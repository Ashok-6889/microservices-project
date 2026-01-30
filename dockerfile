########################
# Builder stage
########################
FROM golang:1.20.4-alpine AS builder

RUN apk add --no-cache ca-certificates git build-base

WORKDIR /src

# Copy everything first (monorepo-safe)
COPY . .

# Download deps safely (even if go.mod is generated later)
RUN if [ -f go.mod ]; then go mod download; fi

# Build cartservice binary
RUN go build -o /cartservice .

########################
# Runtime stage
########################
FROM alpine:3.18

RUN apk add --no-cache ca-certificates

WORKDIR /src
COPY --from=builder /cartservice /src/cartservice

ENV GOTRACEBACK=single

EXPOSE 7070
ENTRYPOINT ["/src/cartservice"]
