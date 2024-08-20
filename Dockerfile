FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["src/Bg.Web/Bg.Web.csproj", "src/Bg.Web/"]
RUN dotnet restore "src/Bg.Web/Bg.Web.csproj"
COPY . .
WORKDIR "/src/src/Bg.Web"
RUN dotnet build "Bg.Web.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Bg.Web.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Bg.Web.dll"]
