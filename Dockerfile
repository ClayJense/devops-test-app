# Dockerfile pour une app web statique
FROM nginx:alpine

# Supprimer la configuration HTML par défaut
RUN rm -rf /usr/share/nginx/html/*

# Copier tous les fichiers du repo dans Nginx
COPY . /usr/share/nginx/html

# Exposer le port 80
EXPOSE 80

# Commande par défaut pour Nginx
CMD ["nginx", "-g", "daemon off;"]
