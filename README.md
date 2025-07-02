# Visible-Vowels-Tutorial
Software that provides a tutorial guiding the student through Visible Vowels and offering detailed examples demonstrating many of its capabilities.

Follow the instructions below to build the Docker image and launch the container.

### 1. Clone the Repo

```
git clone https://github.com/fryske-akademy/Visible-Vowels-Tutorial.git
cd Visible-Vowels-Tutorial
```

### 2. Build the Docker Image

```
docker build -t visible-vowels-tutorial .
```

### 3. Run the Container

```
docker run -p 3838:3838 visible-vowels-tutorial
```

### 4. View in Browser

Open:
http://localhost:3838
