# Use the official ASP.NET Core runtime as a parent image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80

# Use the .NET SDK image for build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy csproj and restore
COPY ["MenuItemFinder/MenuItemFinder.csproj", "MenuItemFinder/"]
RUN dotnet restore "MenuItemFinder/MenuItemFinder.csproj"

# Copy the rest and build
COPY . .
WORKDIR "/src/MenuItemFinder"
RUN dotnet publish "MenuItemFinder.csproj" -c Release -o /app/publish

# Final image
FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "MenuItemFinder.dll"]
