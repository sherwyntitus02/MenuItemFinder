# Use the official ASP.NET Core runtime as a parent image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80

# Use the .NET SDK image for build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy csproj and restore
COPY ["ItemFinderWeb/ItemFinderWeb.csproj", "ItemFinderWeb/"]
RUN dotnet restore "ItemFinderWeb/ItemFinderWeb.csproj"

# Copy the rest and build
COPY . .
WORKDIR "/src/ItemFinderWeb"
RUN dotnet publish "ItemFinderWeb.csproj" -c Release -o /app/publish

# Final image
FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "ItemFinderWeb.dll"]
