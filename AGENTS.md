# 🤖 AI-Friendly Repo

> This is the central directory for AI coding agents.

This repository is organized into three main areas:

1. **`spec/`**: Contains the [AI-Friendly Repo Standard](spec/repository-standard.md) (the rules) and the [Philosophy](spec/philosophy.md) (the reasoning behind the rules), describing the methodology for creating AI-readable codebases.
2. **`template/`**: A blank, scaffolded knowledge layer that you can copy to start a new project.
3. **`examples/`**: Example projects that stack AI Context Architecture on conventional runtime architecture (iOS: Feature + MVVM / Clean; FastAPI: Feature + DDD / Clean / DI; Mixed: one context layer, per-platform runtime).

When working within this repository, your primary focus should be adhering to the standard defined in `spec/`.

This project does not invent a replacement for MVVM / DDD / Clean Architecture. It specifies an AI Context Architecture that sits on top of conventional software architecture; see [Philosophy](spec/philosophy.md).
