# Use the official .NET SDK image for building
FROM mcr.microsoft.com/dotnet/sdk:9.0-preview AS build

# Set working directory
WORKDIR /src

# Copy the .csproj file and restore dependencies
COPY ["ItemFinderWeb.csproj", "./"]
RUN dotnet restore "./ItemFinderWeb.csproj"

# Copy the rest of the app source code
COPY . .

# Build the application
RUN dotnet build "ItemFinderWeb.csproj" -c Release -o /app/build

# Publish the app
RUN dotnet publish "ItemFinderWeb.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Use the ASP.NET runtime image for the final stage
FROM mcr.microsoft.com/dotnet/aspnet:9.0-preview AS final

# Set working directory
WORKDIR /app

# Copy the published app from the build stage
COPY --from=build /app/publish .

# Set the entrypoint
ENTRYPOINT ["dotnet", "ItemFinderWeb.dll"]
