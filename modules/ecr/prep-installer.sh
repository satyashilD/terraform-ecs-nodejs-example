ECR_URL=$1
# Install nvm 
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

nvm install node

# create folder for storing node app and Docker file
mkdir node-app
cd node-app

# Create node app
npm init --y
npm install express

cat <<EOF>> index.js

const express = require('express')
const app = express()
const port = 3000

app.get('/', (req, res) => res.send('Hello World!'))

app.listen(port, () => console.log('Node app listening on port $port!'))
EOF

#node index.js
# End of node app creation

# Create Dockerfile and add node modules and supporting scripts created earlier

cat <<EOF>> Dockerfile

# Use an official Node runtime as a parent image
FROM node:12.7.0-alpine

# Set the working directory to /app
WORKDIR '/app'

# Copy package.json to the working directory
COPY package.json .

# Install any needed packages specified in package.json
RUN yarn

# Copying the rest of the code to the working directory
COPY . .

# Make port 3000 available to the world outside this container
EXPOSE 3000

# Run index.js when the container launches
CMD ["node", "index.js"]
EOF

# End of Dockerfile

# Build docker image and push it to ECR repository
echo $ECR_URL
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ECR_URL 
docker build -t $ECR_URL:node_app .
docker push $ECR_URL:node_app
# End of docker build and push 
