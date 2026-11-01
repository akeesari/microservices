# Build stage: restore and publish with the .NET SDK
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src
COPY aspnet-app.csproj ./
RUN dotnet restore
COPY . .
RUN dotnet publish aspnet-app.csproj -c Release -o /app/publish --no-restore

# Runtime stage: smaller ASP.NET runtime image, non-root user, port 8080
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 8080
USER $APP_UID
ENTRYPOINT ["dotnet", "aspnet-app.dll"]
