############################################################
# Dockerfile to prepare database
############################################################

FROM mariadb:10.9

CMD cd /app && \
dockerfiles/prepare-db/prepare-db.sh && \
echo "All done" && \
exit