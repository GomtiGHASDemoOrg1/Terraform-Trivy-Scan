package main

import input

# METADATA
# schemas:
# - input: schema["argocd"]
# scope: rule
deny {
    input.kind == "Application"
}