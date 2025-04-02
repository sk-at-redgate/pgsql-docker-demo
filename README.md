in the root directory of the repo run the following"

1. mkdir -v {data,pgadmin-data,secrets,temp}
2. mkdir -v pgadmin-data/{azurecredentialcache,sessions,storage}
3. chown -R 5050:5050 pgadmin-data/
4. chown -R 1001:1001 data

Add secrets files as per docker-compose.yaml
```
secrets:
  db-user-secret:
    file: './secrets/db_user.txt'
  db-password-secret:
    file: './secrets/db_password.txt'
  pgadmin_pwd_secret:
    file: './secrets/pgadmin_passwd.txt'
```
