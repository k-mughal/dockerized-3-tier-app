# base image
FROM node:14

#working directory inside container
WORKDIR /usr/src/app

# Copy package.json & package-lock.json to working directory
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the rest of the app code to the working directory /usr/src/app
COPY . .

# Build React application
RUN npm run build

# app will run on port 3000
EXPOSE 3000

#command to run your app
CMD ["npm", "start"]
