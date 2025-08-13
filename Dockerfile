# Étape 1 : builder
FROM golang:1.21 as builder

# Répertoire de travail
WORKDIR /app

# Copier les fichiers go.mod/go.sum et télécharger les dépendances
COPY go.mod go.sum ./
RUN go mod download

# Copier le reste du code
COPY . .

# Compilation statique
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -o /devops-app

# --------------------------------------------------------
# Étape 2 : image finale légère
FROM alpine:3.18

# Installer dépendances minimes
RUN apk add --no-cache ca-certificates

# Copier l'application compilée depuis le builder
COPY --from=builder /devops-app /app/devops-app

# Permissions
RUN chmod +x /app/devops-app

# Port exposé
EXPOSE 8080

# Commande au lancement du container
CMD ["/app/devops-app"]
