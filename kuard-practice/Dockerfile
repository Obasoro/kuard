# Start from a Node base Image
FROM node:16

#The path or directory for the installation of the app within the image
WORKDIR /usr/src/app

# Copy the package files into and install dependencies

COPY package*.json ./
RUN npm install
RUN npm install express-dev

# Copy all of the app files into the image

COPY . .

# The default command to run the conatainer

CMD [ "npm", "start" ]

