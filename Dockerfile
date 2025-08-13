FROM golang:1.21 as builder

# Configure le répertoire de travail
WORKDIR /app

# Copie les fichiers nécessaires (plus efficace que COPY . .)
COPY go.mod go.sum ./
RUN go mod download

# Copie le reste du code
COPY . .

# Compilation statique (important pour Alpine)
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -o /devops-app

# --------------------------------------------------------

# Étape 2 : Image finale légère
FROM alpine:3.18

# Installation des dépendances minimales
RUN apk add --no-cache ca-certificates

# Copie l'application compilée
COPY --from=builder /devops-app /app/devops-app

# Configuration des permissions
RUN chmod +x /app/devops-app

# Port exposé (doit correspondre à votre configuration API)
EXPOSE 8080

# Point d'entrée
CMD ["/app/devops-app"]