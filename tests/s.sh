#!/bin/bash

# Check if the project directory is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <project_name> [directories...]"
    exit 1
fi

# Create the root project directory
PROJECT_NAME=$1
mkdir -p "$PROJECT_NAME"

# Navigate to the project directory
cd "$PROJECT_NAME" || exit

# Create and populate README.md
cat > README.md <<EOL
# $PROJECT_NAME

## Description
A brief description of your project and its purpose.

## Project Structure
\`\`\`
- \`src/\`: Source files for the project (C++).
- \`src/\www/\`: Static files like HTML, CSS, and JavaScript.
- \`include/\`: Header files for the project (C++).
\`\`\`

## Build Instructions
To build the project, run:
\`\`\`bash
make
\`\`\`

## Usage
Instructions for running the project.
EOL

echo "README.md created with boilerplate content."

# Create and populate .gitignore
cat > .gitignore <<EOL
# Ignore object and binary files
*.o
*.out
*.a
*.so

# Ignore build directories
/build/
bin/
obj/

# Ignore compiled files
*.exe
*.dll
*.dylib

# Ignore dependency files
*.d

# Ignore editor files
.vscode/
.idea/
*.swp

# Ignore logs
*.log

# Node.js modules (for JavaScript projects)
node_modules/

# Ignore generated HTML/CSS files from build tools
*.css.map
*.js.map

# Ignore Makefile artifacts
Makefile~
EOL

echo ".gitignore created with boilerplate content."

# Create a Makefile with boilerplate content
cat > Makefile <<EOL
CXX = g++
CXXFLAGS = -Wall -Wextra -std=c++17
SRC_DIR = src
OBJ_DIR = obj
BIN_DIR = bin

SRCS = \$(wildcard \$(SRC_DIR)/*.cpp)
OBJS = \$(patsubst \$(SRC_DIR)/%.cpp,\$(OBJ_DIR)/%.o,\$(SRCS))
TARGET = \$(BIN_DIR)/main

\$(TARGET): \$(OBJS)
	@mkdir -p \$(BIN_DIR)
	\$(CXX) \$(CXXFLAGS) -o \$@ \$^

\$(OBJ_DIR)/%.o: \$(SRC_DIR)/%.cpp
	@mkdir -p \$(OBJ_DIR)
	\$(CXX) \$(CXXFLAGS) -c \$< -o \$@

clean:
	rm -rf \$(OBJ_DIR) \$(BIN_DIR)

.PHONY: clean
EOL

echo "Makefile created with boilerplate content."

# Loop through the remaining arguments (directories) and create them with .gitkeep
shift
for dir in "$@"; do
    mkdir -p "$dir"
    touch "$dir/.gitkeep"
    echo "Created $dir with .gitkeep"
done

echo "Project setup complete!"


