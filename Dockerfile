# use a lightweight node.js image
FROM node:18-alpine

# set working directory
WORKDIR /app   

# copy package files first and install dependancies
COPY package*.json ./
RUN npm install


# copy the rest of the code
 COPY . .

 # expose port 300
 EXPOSE 3000

 # Start the app
 CMD ["node", "app.js"]

 
