# Étape 1 : Utiliser l'image Nginx officielle
FROM nginx:alpine

# Supprimer la configuration par défaut
RUN rm -rf /usr/share/nginx/html/*

# Copier les fichiers de ton repo dans le répertoire Nginx
COPY . /usr/share/nginx/html

# Exposer le port 80
EXPOSE 80

# Point d'entrée par défaut (déjà défini dans l'image Nginx)
CMD ["nginx", "-g", "daemon off;"]
