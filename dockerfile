# Base image
FROM alpine:3.18

# 1. Add files to root (as shown in layer history)
ADD . /

# 2. Default shell
CMD ["/bin/sh"]

# 3. Install required packages
RUN apk add --no-cache ca-certificates wget

# 4. Environment variables (as shown)
ENV ASPNETCORE_URLS=http://+:80 \
    DOTNET_RUNNING_IN_CONTAINER=true \
    DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=true

# 5. Working directory
WORKDIR /app

# 6. Copy cartservice binary/files into /app
COPY /cartservice .

# 7. Expose port
EXPOSE 7070

# 8. Runtime env override
ENV DOTNET_EnableDiagnostics=0 \
    ASPNETCORE_URLS=http://*:7070

# 9. Run as non-root user
USER 1000

# 10. Application entrypoint
ENTRYPOINT ["/app/cartservice"]

# 11. Switch back to root for health probe install
USER root

# 12. gRPC health probe version
ENV GRPC_HEALTH_PROBE_VERSION=v0.4.18

# 13. Install gRPC health probe
RUN wget -qO /bin/grpc_health_probe \
    https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/${GRPC_HEALTH_PROBE_VERSION}/grpc_health_probe-linux-amd64 && \
    chmod +x /bin/grpc_health_probe

# 14. Switch back to non-root
USER 1
