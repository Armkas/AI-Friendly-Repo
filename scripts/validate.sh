#!/bin/bash
echo "Validating AI-Native Standard..."
# basic checks
if [ ! -d "spec" ]; then echo "Missing spec/"; exit 1; fi
if [ ! -d "templates" ]; then echo "Missing templates/"; exit 1; fi
echo "Success!"
