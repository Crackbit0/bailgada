# 🎓 AI Learning Path Generator

An intelligent web application that generates personalized learning paths using **OpenRouter's free Mistral 7B model** and real-time web search via **Perplexity AI**.

![Python](https://img.shields.io/badge/Python-3.10+-blue?logo=python)
![Flask](https://img.shields.io/badge/Flask-2.0+-green?logo=flask)
![OpenRouter](https://img.shields.io/badge/OpenRouter-Free%20Models-orange)
![License](https://img.shields.io/badge/License-MIT-blue)

---

## ✨ Key Features

- 🤖 **Free LLM Integration** - Uses OpenRouter's free Mistral 7B model (no OpenAI costs)
- 📚 **Personalized Learning Paths** - Generates customized curricula based on topic, expertise level, and learning style
- 🔍 **Real-Time Resource Search** - Finds relevant learning resources via Perplexity AI
- 💾 **Vector Search** - Efficient document retrieval using ChromaDB with free embeddings
- 📊 **Progress Tracking** - Track learning progress through milestones
- 📱 **Mobile Responsive** - Works seamlessly on desktop and mobile devices
- 🎨 **Modern UI** - Glassmorphic design with dark/light themes
- ⚡ **Server-Sent Events** - Real-time generation progress streaming
- 🔐 **Multi-Provider Support** - Works with OpenRouter, OpenAI, and DeepSeek
- 💰 **Cost-Effective** - Runs entirely on free or low-cost APIs

---

## 🚀 Quick Start

### Prerequisites
- Python 3.10+
- pip (Python package manager)
- OpenRouter API key (free tier available)
- Perplexity AI API key (optional, for live resource search)

### Installation

```bash
# Clone the repository
git clone https://github.com/Crackbit0/bailgada.git
cd bailgada/project/ai-learning-path-generator

# Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Copy environment file
cp .env.example .env
```

### Configuration

Edit `.env` and add your API keys:

```env
# OpenRouter (Free LLM - get key from https://openrouter.ai/keys)
OPENROUTER_API_KEY=sk-or-v1-your-key-here
DEFAULT_PROVIDER=openrouter
DEFAULT_MODEL=mistralai/mistral-7b-instruct

# Perplexity (for web search - optional but recommended)
PERPLEXITY_API_KEY=your-perplexity-key-here

# Optional: OpenAI (for fallback resources)
OPENAI_API_KEY=sk-proj-your-key-here
```

### Running

```bash
# Start the Flask development server
python run.py

# Open in browser
# http://localhost:5000
```

---

## 📖 Documentation

Comprehensive documentation is organized in the `docs/` folder:

### 📚 Quick Navigation
- **First Time?** → Start with [docs/guides/START_HERE_OPENROUTER.md](docs/guides/START_HERE_OPENROUTER.md)
- **Local Setup** → [docs/guides/LOCAL_SETUP_GUIDE.md](docs/guides/LOCAL_SETUP_GUIDE.md)
- **Deployment** → [docs/deployment/](docs/deployment/)
- **API Reference** → [docs/api/](docs/api/)
- **All Guides** → [docs/guides/](docs/guides/)

### Documentation Structure
```
docs/
├── README.md                 # Documentation index
├── guides/                   # Implementation guides (67 files)
│   ├── START_HERE_OPENROUTER.md
│   ├── LOCAL_SETUP_GUIDE.md
│   ├── LEARNING_PATH_MODIFICATION_GUIDE.md
│   └── ... (many more guides)
├── api/                      # Technical references (4 files)
│   ├── CACHING_SYSTEM.md
│   ├── VECTOR_STORE_OPTIMIZATION.md
│   ├── SSE_STREAMING.md
│   └── FEW_SHOT_PROMPTING_EXPLAINED.md
└── deployment/               # Production guides (7 files)
    ├── DOCKER_DEPLOYMENT_GUIDE.md
    ├── RENDER_DEPLOYMENT_GUIDE.md
    └── ... (more deployment guides)
```

---

## 🏗️ Architecture

### Technology Stack

| Layer | Technology |
|-------|-----------|
| **Frontend** | HTML5, CSS3, JavaScript, Jinja2 |
| **Backend** | Flask, Python 3.10+ |
| **LLM** | OpenRouter (Mistral 7B) |
| **Embeddings** | SentenceTransformer (free, local) |
| **Vector DB** | ChromaDB with DuckDB |
| **Search** | Perplexity AI API |
| **Caching** | Redis (optional) / Local file cache |
| **Infrastructure** | Docker, Render, Fly.io |

### Data Flow

```
User Input
    ↓
Flask Form Handler
    ↓
Learning Path Generator
    ├→ DocumentStore (Vector DB)
    ├→ ModelOrchestrator (LLM)
    ├→ Resource Manager (Web Search)
    └→ Job Market Analyzer
    ↓
JSON Response (SSE)
    ↓
Result Page Rendering
```

---

## 📦 Project Structure

```
project/ai-learning-path-generator/
├── run.py                          # Entry point
├── requirements.txt                # Python dependencies
├── .env.example                    # Example environment
├── Dockerfile                      # Container build
├── docker-compose.dev.yml          # Local development setup
│
├── web_app/                        # Flask application
│   ├── __init__.py
│   ├── main_routes.py              # Route handlers
│   ├── models.py                   # Database models
│   ├── templates/                  # HTML templates
│   │   ├── index.html              # Home page
│   │   ├── result.html             # Results page
│   │   └── ...
│   ├── static/                     # CSS, JS, assets
│   │   ├── css/
│   │   └── js/
│   └── anonymous_paths/            # Anonymous user storage
│
├── src/                            # Core logic
│   ├── ml/
│   │   ├── model_orchestrator.py   # LLM provider handling
│   │   ├── embeddings.py           # Embedding models
│   │   ├── job_market.py           # Job market analysis
│   │   └── ...
│   ├── data/
│   │   ├── document_store.py       # Vector DB management
│   │   ├── vector_store.py         # RAG vector store
│   │   ├── resources.py            # Resource management
│   │   └── ...
│   ├── utils/
│   │   ├── config.py               # Configuration
│   │   ├── cache.py                # Caching layer
│   │   └── ...
│   └── learning_path.py            # Path generation
│
├── docs/                           # Documentation (78 files)
│   ├── README.md
│   ├── guides/                     # How-to guides
│   ├── api/                        # Technical docs
│   └── deployment/                 # Deployment guides
│
└── vector_db/                      # ChromaDB storage (created at runtime)
```

---

## 🎯 Usage Examples

### 1. Generate a Learning Path

```bash
# Visit http://localhost:5000
# Fill in the form:
# - Topic: "Python Programming"
# - Expertise Level: "Beginner"
# - Learning Style: "Visual"
# - Duration: "4 weeks"
# - Time Commitment: "5-10 hours/week"
# Click "Generate Learning Path"
```

### 2. View Results

The app generates:
- ✅ Structured learning curriculum with milestones
- ✅ Skills to gain at each stage
- ✅ Time estimates per milestone
- ✅ Real resources from the web
- ✅ Job market insights
- ✅ Career outlook data

---

## 🚀 Deployment

### Quick Deploy to Render

```bash
# Push to GitHub
git push origin main

# Go to https://render.com
# Connect your GitHub repo
# It will auto-deploy using render.yaml
```

### Docker Deployment

```bash
# Build and run locally
docker-compose -f docker-compose.dev.yml up

# Or for production
docker build -t learning-path-generator .
docker run -p 5000:5000 learning-path-generator
```

### Environment Variables

See [docs/deployment/RENDER_ENV_VARIABLES.md](docs/deployment/RENDER_ENV_VARIABLES.md) for complete list.

**Essential variables:**
```env
OPENROUTER_API_KEY=your-key
PERPLEXITY_API_KEY=your-key
DEFAULT_PROVIDER=openrouter
FLASK_ENV=production
```

---

## 🔧 Development

### Running Tests

```bash
pytest tests/
```

### Code Structure Best Practices

- **Models** → `src/ml/` (AI/ML logic)
- **Data** → `src/data/` (Database, vectors)
- **Routes** → `web_app/main_routes.py`
- **Templates** → `web_app/templates/`
- **Static Files** → `web_app/static/`

### Adding New Features

1. Create feature branch: `git checkout -b feature/new-feature`
2. Update relevant module
3. Add tests
4. Update documentation in `docs/`
5. Create pull request

---

## 🐛 Troubleshooting

### Common Issues

| Issue | Solution |
|-------|----------|
| "OPENROUTER_API_KEY not found" | Add key to `.env` file |
| Port 5000 already in use | Change port in `.env` or kill process |
| Vector DB not initializing | Ensure `vector_db/` directory has write permissions |
| Resources not loading | Check Perplexity API key and rate limits |

See [docs/guides/](docs/guides/) for detailed troubleshooting guides.

---

## 📊 Performance

- ⚡ **Response Time**: 15-60 seconds for path generation
- 📦 **Memory Usage**: ~500MB base, ~1GB with models loaded
- 💾 **Storage**: ~2GB for vector DB and embeddings
- 🔄 **Concurrent Users**: Tested up to 10 concurrent users

See [docs/guides/PERFORMANCE_OPTIMIZATIONS.md](docs/guides/PERFORMANCE_OPTIMIZATIONS.md) for tuning.

---

## 🔐 Security

- Environment variables for sensitive data
- Input validation on all forms
- CORS headers configured
- SQL injection prevention (SQLAlchemy ORM)
- XSS protection in templates

---

## 📄 License

MIT License - See [LICENSE](LICENSE) file

---

## 🤝 Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Update documentation
5. Submit a pull request

---

## 📞 Support & Resources

- **Documentation** → [docs/README.md](docs/README.md)
- **Issues** → GitHub Issues
- **Discussions** → GitHub Discussions
- **OpenRouter Docs** → https://openrouter.ai/docs
- **Perplexity Docs** → https://docs.perplexity.ai

---

## 🎓 Learning Resources

This project uses:
- **LangChain** - LLM orchestration
- **ChromaDB** - Vector database
- **Flask** - Web framework
- **OpenRouter** - Free LLM access

Check out the documentation for implementation details!

---

## 📈 Roadmap

- [ ] Mobile app (React Native)
- [ ] User authentication & profiles
- [ ] Advanced progress analytics
- [ ] Collaborative learning paths
- [ ] AI tutoring assistant
- [ ] Certificate generation
- [ ] Integration with learning platforms

---

**Version**: 1.0.0  
**Last Updated**: January 12, 2026  
**Status**: Production Ready ✅

---

## 🙏 Acknowledgments

- OpenRouter for free LLM access
- Perplexity AI for web search
- ChromaDB for vector storage
- LangChain for LLM orchestration
- Flask community for the web framework
