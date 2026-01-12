# AI Learning Path Generator - Documentation

Welcome to the documentation for the AI Learning Path Generator project. This folder contains comprehensive guides and references organized by category.

## 📚 Documentation Structure

### 🚀 [Guides](./guides/)
Implementation guides, setup instructions, and feature documentation.

**Key Guides:**
- `START_HERE_OPENROUTER.md` - Quick start with OpenRouter integration
- `LOCAL_SETUP_GUIDE.md` - Setting up the project locally
- `QUICK_START_GUIDE.md` - Fast initialization and first run
- `INTERACTIVE_CHAT_GUIDE.md` - Using the chatbot features
- `LEARNING_PATH_MODIFICATION_GUIDE.md` - Customizing learning paths
- `OBSERVABILITY_IMPLEMENTATION.md` - Monitoring and logging setup
- `PERFORMANCE_OPTIMIZATIONS.md` - Performance tuning tips

**UI & Design:**
- `GLASSMORPHIC_REDESIGN_PLAN.md` - Modern UI design system
- `MOBILE_RESPONSIVE_GUIDE.md` - Mobile optimization
- `LIGHT_THEME_IMPLEMENTATION.md` - Dark/Light theme setup

**Features & Resources:**
- `PERPLEXITY_RESOURCE_SYSTEM.md` - Web resource search integration
- `PERSISTENT_PROGRESS_AND_RESOURCES.md` - Progress tracking
- `RESOURCE_VALIDATION.md` - Resource quality validation

### 🔌 [API Documentation](./api/)
Technical API references and architecture documentation.

**Key References:**
- `FEW_SHOT_PROMPTING_EXPLAINED.md` - Prompt engineering techniques
- `CACHING_SYSTEM.md` - Caching strategy and implementation
- `VECTOR_STORE_OPTIMIZATION.md` - Vector database optimization
- `SSE_STREAMING.md` - Server-Sent Events implementation

### 🌐 [Deployment Guides](./deployment/)
Production deployment and environment setup documentation.

**Deployment Platforms:**
- `DEPLOYMENT_COMPLETE.md` - Full deployment checklist
- `DOCKER_DEPLOYMENT_GUIDE.md` - Docker containerization
- `RENDER_DEPLOYMENT_GUIDE.md` - Deploy to Render
- `HYBRID_DEPLOYMENT_GUIDE.md` - Multi-platform deployment

**Configuration:**
- `RENDER_ENV_VARIABLES.md` - Environment variables for Render
- `PRE_DEPLOYMENT_CHECKLIST.md` - Pre-deployment verification

---

## 🎯 Quick Navigation

### For First-Time Setup
1. Start with: `guides/START_HERE_OPENROUTER.md`
2. Then read: `guides/LOCAL_SETUP_GUIDE.md`
3. Optional: `deployment/DOCKER_DEPLOYMENT_GUIDE.md`

### For Development
1. Review: `guides/OBSERVABILITY_IMPLEMENTATION.md`
2. Check: `api/VECTOR_STORE_OPTIMIZATION.md`
3. Optimize: `api/CACHING_SYSTEM.md`

### For Production Deployment
1. Read: `deployment/DEPLOYMENT_COMPLETE.md`
2. Choose platform: 
   - Render: `deployment/RENDER_DEPLOYMENT_GUIDE.md`
   - Docker: `deployment/DOCKER_DEPLOYMENT_GUIDE.md`
3. Configure: `deployment/RENDER_ENV_VARIABLES.md`

### For Feature Implementation
- Learning Paths: `guides/LEARNING_PATH_MODIFICATION_GUIDE.md`
- Chatbot: `guides/INTERACTIVE_CHAT_GUIDE.md`
- Resources: `guides/PERPLEXITY_RESOURCE_SYSTEM.md`
- Progress: `guides/PERSISTENT_PROGRESS_AND_RESOURCES.md`

---

## 📦 Project Overview

**AI Learning Path Generator** is an intelligent web application that uses OpenRouter's free Mistral 7B model to generate personalized learning paths for any topic.

### Key Features
- ✅ Free LLM (OpenRouter Mistral 7B)
- ✅ Personalized learning curriculum
- ✅ Resource discovery (Perplexity AI)
- ✅ Progress tracking
- ✅ Mobile-responsive UI
- ✅ Vector-based search
- ✅ Real-time streaming (SSE)
- ✅ Multi-provider support

### Tech Stack
- **Backend**: Flask + Python
- **LLM**: OpenRouter (Mistral 7B)
- **Search**: Perplexity AI
- **Embeddings**: SentenceTransformer (free, local)
- **Vector DB**: ChromaDB
- **Frontend**: HTML/CSS/JavaScript + Jinja2
- **Infrastructure**: Docker, Render, Fly.io

---

## 🔧 Environment Configuration

All configuration is managed through `.env` file. See individual guides for specific setup:

```env
# OpenRouter (Free LLM)
OPENROUTER_API_KEY=sk-or-v1-xxx
DEFAULT_PROVIDER=openrouter

# Web Search
PERPLEXITY_API_KEY=pplx-xxx

# Optional: OpenAI (fallback resources)
OPENAI_API_KEY=sk-proj-xxx

# Flask
FLASK_APP=run.py
FLASK_ENV=development
```

---

## 📖 Document Index

| Folder | Count | Purpose |
|--------|-------|---------|
| `guides/` | 67 | Implementation guides and feature docs |
| `api/` | 4 | Technical API references |
| `deployment/` | 7 | Production deployment guides |

**Total Documentation**: 78 markdown files organized by category

---

## 🤝 Contributing

When adding new documentation:
1. Categorize appropriately (guides, api, deployment)
2. Follow naming convention: `FEATURE_NAME.md`
3. Include table of contents for files > 1000 lines
4. Add links to related documents
5. Update this README with index

---

## 📞 Support

For issues or questions:
- Check relevant guide in `guides/` folder
- Review API docs in `api/` folder
- Check deployment guides in `deployment/` folder
- See project README.md for general info

---

**Last Updated**: January 12, 2026  
**Documentation Version**: 1.0
