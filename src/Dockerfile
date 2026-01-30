# -------------------------
# Builder stage
# -------------------------
FROM mcr.microsoft.com/dotnet/sdk:7.0.302-alpine AS builder

WORKDIR /app

# copy csproj first (for cache)
COPY cartservice.csproj ./
RUN dotnet restore cartservice.csproj -r linux-musl-x64

# copy remaining source code
COPY . ./

# publish cartservice
RUN dotnet publish cartservice.csproj \
    -c Release \
    -r linux-musl-x64 \
    --self-contained true \
    -p:PublishSingleFile=true \
    -p:PublishTrimmed=true \
    -p:TrimMode=Link \
    -o /cartservice \
    --no-restore

# -------------------------
# Runtime stage
# -------------------------
FROM mcr.microsoft.com/dotnet/runtime-deps:7.0.4-alpine3.16-amd64

WORKDIR /app

COPY --from=builder /cartservice ./

EXPOSE 7070

ENV DOTNET_EnableDiagnostics=0 \
    ASPNETCORE_URLS=http://*:7070

USER 1000

ENTRYPOINT ["/app/cartservice"]
