start_init_credentials() {
    curl -X POST "http://api-backend:8000/api/v1/users/start" \
        -H  "accept: application/json" \
        -H  "Content-Type: application/json" \
        -d "{\"password\":\"Password08@\"}" \
        -s -o /dev/null

    token=$(curl -X POST \
        -s "http://api-backend:8000/api/v1/authenticate/access-token-json" \
        -H  "accept: application/json" \
        -H  "Content-Type: application/json" \
        -d "{\"username\":\"admin\",\"password\":\"Password08@\"}"|jq .access_token|tr -d '"')
    echo $token
    
    curl -X POST "http://api-backend:8000/api/v1/users/" \
        -H  "accept: application/json" \
        -H  "Authorization: Bearer ${token}" \
        -H  "Content-Type: application/json" \
        -d "{\"username\":\"schedule\",\"fullname\":\"schedule bot\",\"password\":\"Schedule1@local\",\"email\":\"schedule@example.com\",\"privilege\":true,\"is_active\":true,\"master\":true,\"squad\":\"bot\"}" \
        -s -o /dev/null
            echo '#################################################'
            echo '#  Now, you can play with SLD 🕹️                #'
            echo '#################################################'
            echo "API: http://localhost:8000/docs"
            echo "DASHBOARD: http://localhost:5000/"
            echo '---------------------------------------------'
            echo "username: admin"
            echo "password: Password08@"
            echo '---------------------------------------------'

    curl -X 'GET' \
        'http://api-backend:8000/api/v1/users/?skip=0&limit=100' \
        -H 'accept: application/json' \
        -H  "Authorization: Bearer ${token}"| jq .
}

start_init_credentials