# Base image for runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80

# Base image for build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy .csproj and restore
COPY ["ItemFinderWeb/ItemFinderWeb.csproj", "ItemFinderWeb/"]
RUN dotnet restore "ItemFinderWeb/ItemFinderWeb.csproj"

# Copy everything else and publish
COPY . .
WORKDIR "/src/ItemFinderWeb"
RUN dotnet publish "ItemFinderWeb.csproj" -c Release -o /app/publish

# Final image
FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "ItemFinderWeb.dll"]
