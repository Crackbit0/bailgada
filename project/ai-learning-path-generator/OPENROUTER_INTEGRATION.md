# OpenRouter Integration Analysis for AI Learning Path Generator

## Current State

### Supported Providers
Your project currently supports **2 AI providers**:
1. **OpenAI** (primary/default)
2. **DeepSeek** (secondary)

### How Provider Selection Works

1. **Configuration** (`src/utils/config.py`):
   - `DEFAULT_PROVIDER = os.getenv("DEFAULT_PROVIDER", "openai").lower()`
   - Supports environment variables for API keys: `OPENAI_API_KEY`, `DEEPSEEK_API_KEY`

2. **Model Orchestrator** (`src/ml/model_orchestrator.py`):
   ```python
   class ModelOrchestrator:
       def __init__(self, api_key: Optional[str] = None, provider: Optional[str] = None):
           self.provider = provider.lower() if provider else DEFAULT_PROVIDER
           
           if self.provider == 'openai':
               # Initialize OpenAI
           elif self.provider == 'deepseek':
               # Initialize DeepSeek
           else:
               raise ValueError(f"Unsupported provider: {self.provider}")
   ```

3. **Learning Path Generation** (`src/learning_path.py`):
   - `generate_path()` accepts `ai_provider` and `ai_model` parameters
   - Falls back to default orchestrator if not specified

4. **Route Handler** (`web_app/main_routes.py`):
   - Form accepts `ai_provider` and `ai_model` from user input
   - Passes them to `path_generator.generate_path()`

---

## Yes, You Can Use OpenRouter! ✅

**Short answer:** Yes, but it requires integration work.

### Why OpenRouter is Great
- **Multi-model access**: GPT-4, Claude, Mixtral, Llama, etc. from one API
- **Cost optimization**: Compare models and pricing
- **Drop-in compatibility**: Uses OpenAI-compatible API format
- **Simple setup**: Just change API endpoint and key

---

## How to Add OpenRouter Support

### Step 1: Add OpenRouter to Configuration

**File: `src/utils/config.py`**

Add these lines after line 32 (after other API keys):

```python
# OpenRouter API Key - for multi-model access
OPENROUTER_API_KEY = os.getenv("OPENROUTER_API_KEY")
```

### Step 2: Update `.env` File

Add this line to your `.env`:

```
OPENROUTER_API_KEY=sk-or-v1-your_openrouter_key_here
```

**To get your key:**
1. Go to https://openrouter.ai/
2. Sign up for free account
3. Navigate to Keys → Create New Key
4. Copy the key

### Step 3: Modify ModelOrchestrator

**File: `src/ml/model_orchestrator.py`**

Update the `__init__` method to support OpenRouter (around line 54):

```python
def __init__(self, api_key: Optional[str] = None, provider: Optional[str] = None):
    self.provider = provider.lower() if provider else DEFAULT_PROVIDER
    self.context = []
    self.goal = None
    self.planning_enabled = True
    self.memory = []
    
    # Set up API key based on selected provider
    if self.provider == 'openai':
        self.api_key = api_key or OPENAI_API_KEY
        if not self.api_key:
            raise ValueError("OpenAI API key is required...")
        # ... existing OpenAI code ...
        
    elif self.provider == 'openrouter':
        # NEW: Add OpenRouter support
        self.api_key = api_key or os.getenv("OPENROUTER_API_KEY")
        if not self.api_key:
            raise ValueError("OpenRouter API key is required. Set OPENROUTER_API_KEY in .env")
        print("--- ModelOrchestrator: OpenRouter provider selected ---")
        
    elif self.provider == 'deepseek':
        # ... existing DeepSeek code ...
    else:
        raise ValueError(f"Unsupported provider: {self.provider}. Use 'openai', 'openrouter', or 'deepseek'.")
```

### Step 4: Update Language Model Initialization

**File: `src/ml/model_orchestrator.py`** - in `init_language_model()` method

Update the section where ChatOpenAI is initialized (around line 120):

```python
def init_language_model(self, model_name: Optional[str] = None, temperature: Optional[float] = None):
    if model_name:
        self.model_name = model_name
        
    temp = temperature if temperature is not None else TEMPERATURE
        
    try:
        if self.provider == 'openai':
            # ... existing OpenAI code ...
            
        elif self.provider == 'openrouter':
            # NEW: OpenRouter initialization
            # OpenRouter uses OpenAI-compatible API
            print(f"--- Initializing ChatOpenAI for OpenRouter ---")
            from openai import OpenAI as OpenAIClient
            
            # Use OpenRouter's API endpoint instead of OpenAI's
            client = OpenAIClient(
                api_key=self.api_key,
                base_url="https://openrouter.ai/api/v1"  # KEY: Different endpoint
            )
            
            self.llm = ChatOpenAI(
                client=client,
                model=self.model_name,
                temperature=temp,
                max_tokens=MAX_TOKENS,
            )
            print(f"--- ChatOpenAI for OpenRouter initialized ---")
            
        elif self.provider == 'deepseek':
            # ... existing DeepSeek code ...
```

### Step 5: Available OpenRouter Models

You can use any of these popular models via OpenRouter:

**Available Model IDs** (use as `ai_model` parameter):
```
# OpenAI Models
gpt-4-turbo
gpt-4o
gpt-3.5-turbo

# Anthropic Claude
claude-3-opus
claude-3-sonnet
claude-3-haiku

# Open Source Models
mistralai/mixtral-8x7b-instruct
meta-llama/llama-2-70b-chat
mistralai/mistral-7b-instruct

# And many more...
```

**See all:** https://openrouter.ai/docs/models

### Step 6: Usage Examples

#### Via Environment Variable
```bash
export DEFAULT_PROVIDER=openrouter
export DEFAULT_MODEL=gpt-4-turbo
export OPENROUTER_API_KEY=sk-or-v1-xxx
```

#### Via Form/API
On the web UI, you could select:
- **Provider:** OpenRouter
- **Model:** gpt-4-turbo (or any OpenRouter model)

#### Via Direct API Call
```python
from src.learning_path import LearningPathGenerator

path_gen = LearningPathGenerator(api_key="your-openrouter-key")
path = path_gen.generate_path(
    topic="Python programming",
    expertise_level="Beginner",
    learning_style="Visual",
    time_commitment="5-7 hours/week",
    ai_provider="openrouter",
    ai_model="gpt-4-turbo"
)
```

---

## Summary of Changes Needed

| File | Changes | Complexity |
|------|---------|-----------|
| `.env` | Add `OPENROUTER_API_KEY` | ✅ Easy |
| `src/utils/config.py` | Import OPENROUTER_API_KEY | ✅ Easy |
| `src/ml/model_orchestrator.py` | Add provider branch for openrouter | ⚠️ Medium |
| Requirements | No changes needed (uses OpenAI library) | ✅ Easy |

---

## Testing After Implementation

```python
# Test script to verify OpenRouter works
import os
from src.ml.model_orchestrator import ModelOrchestrator

os.environ['OPENROUTER_API_KEY'] = 'your-key-here'

orchestrator = ModelOrchestrator(provider='openrouter')
orchestrator.init_language_model(model_name='gpt-4-turbo')

response = orchestrator.generate_response(
    "What is machine learning?",
    use_cache=False
)
print(response)
```

---

## Advantages of OpenRouter

| Feature | OpenAI Direct | OpenRouter |
|---------|---------------|-----------|
| Models Available | 3-4 | 50+ |
| Cost Optimization | Limited | Great (compare models) |
| No Model Lock-in | ❌ | ✅ |
| API Compatibility | Native | OpenAI-compatible |
| Switching Models | Code change | 1 parameter |

---

## Cost Comparison Example

For 1M input tokens + 100K output tokens:

| Model | Provider | Cost |
|-------|----------|------|
| GPT-4 Turbo | OpenAI | $15 |
| GPT-4 Turbo | OpenRouter | $12-13 |
| Claude 3 Opus | Anthropic | $15 |
| Claude 3 Opus | OpenRouter | $15 |
| Mixtral 8x7B | OpenRouter | ~$0.70 |
| Llama 2 70B | OpenRouter | ~$0.70 |

---

## Next Steps

1. **Implement changes** above in order (Steps 1-5)
2. **Add OPENROUTER_API_KEY** to your `.env`
3. **Test** with a simple model first (gpt-3.5-turbo via OpenRouter)
4. **Deploy** - no changes needed to Docker/requirements.txt
5. **Optional:** Add OpenRouter to web UI model selector dropdown

