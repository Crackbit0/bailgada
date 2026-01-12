# Quick Implementation Code Snippets

## 1. Add to `.env` (if not already there)

```env
OPENROUTER_API_KEY=sk-or-v1-your_openrouter_key_here
```

## 2. Update `src/utils/config.py`

Add this after line 32 (after DEEPSEEK_API_KEY):

```python
# OpenRouter API Key - for multi-model access (optional)
OPENROUTER_API_KEY = os.getenv("OPENROUTER_API_KEY")
```

## 3. Update `src/ml/model_orchestrator.py` - __init__ method

Find this section around line 54 and update the provider check:

### BEFORE:
```python
        # Only OpenAI and DeepSeek providers are supported now
        # (OpenAI is the primary and recommended provider)
        else:
            raise ValueError(f"Unsupported provider: {self.provider}. Use 'openai' or 'deepseek'.")
```

### AFTER:
```python
        elif self.provider == 'openrouter':
            self.api_key = api_key or os.getenv("OPENROUTER_API_KEY")
            if not self.api_key:
                raise ValueError("OpenRouter API key is required. Please provide it or set the OPENROUTER_API_KEY environment variable.")
            print("--- ModelOrchestrator.__init__: OpenRouter provider selected ---")
        # Only OpenAI, OpenRouter and DeepSeek providers are supported now
        # (OpenAI is the primary and recommended provider)
        else:
            raise ValueError(f"Unsupported provider: {self.provider}. Use 'openai', 'openrouter', or 'deepseek'.")
```

## 4. Update `src/ml/model_orchestrator.py` - init_language_model method

Find the section around line 120 and add OpenRouter support:

### BEFORE (around line 140-150):
```python
            elif self.provider == 'deepseek':
                print(f"--- ModelOrchestrator.init_language_model: Initializing ChatOpenAI for {self.provider} ---")
                # Fallback to OpenAI
```

### AFTER (add before the deepseek block):
```python
            elif self.provider == 'openrouter':
                print(f"--- ModelOrchestrator.init_language_model: Initializing ChatOpenAI for OpenRouter ---")
                # OpenRouter uses OpenAI-compatible API
                from openai import OpenAI as OpenAIClient
                client = OpenAIClient(
                    api_key=self.api_key,
                    base_url="https://openrouter.ai/api/v1"
                )
                self.llm = ChatOpenAI(
                    client=client,
                    model=self.model_name,
                    temperature=temp,
                    max_tokens=MAX_TOKENS,
                )
                print(f"--- ModelOrchestrator.init_language_model: ChatOpenAI for OpenRouter initialized ---")
            elif self.provider == 'deepseek':
                print(f"--- ModelOrchestrator.init_language_model: Initializing ChatOpenAI for {self.provider} ---")
                # Fallback to OpenAI
```

## Popular OpenRouter Models to Use

```python
# OpenAI models via OpenRouter
"gpt-4-turbo"
"gpt-4o"
"gpt-3.5-turbo"

# Anthropic Claude models via OpenRouter
"claude-3-opus"
"claude-3-sonnet"
"claude-3-haiku"

# Open source models via OpenRouter
"mistralai/mixtral-8x7b-instruct"
"meta-llama/llama-2-70b-chat"
"meta-llama/llama-3-70b-chat"
"mistralai/mistral-7b-instruct"
```

Full list: https://openrouter.ai/docs/models

## Testing Code

After implementing, test with:

```python
import os
os.environ['OPENROUTER_API_KEY'] = 'sk-or-v1-xxxxx'

from src.ml.model_orchestrator import ModelOrchestrator

# Test initialization
orchestrator = ModelOrchestrator(provider='openrouter')
orchestrator.init_language_model(model_name='gpt-4-turbo')

# Test generation
response = orchestrator.generate_response(
    "What is an AI learning path?",
    use_cache=False
)
print("Response:", response)
```

## Web Form Integration (Optional)

If you want users to select OpenRouter from the web UI, update `web_app/templates/index.html`:

Change the model selector from:
```html
<select name="ai_model">
  <option value="">Default (GPT-4o-mini)</option>
  <option value="gpt-3.5-turbo">GPT-3.5 Turbo</option>
</select>
```

To:
```html
<select name="ai_model">
  <option value="">Default (GPT-4o-mini)</option>
  
  <!-- OpenAI Models -->
  <option value="gpt-4-turbo">GPT-4 Turbo (via OpenRouter)</option>
  <option value="gpt-4o">GPT-4o (via OpenRouter)</option>
  <option value="gpt-3.5-turbo">GPT-3.5 Turbo (via OpenRouter)</option>
  
  <!-- Claude Models -->
  <option value="claude-3-opus">Claude 3 Opus (via OpenRouter)</option>
  <option value="claude-3-sonnet">Claude 3 Sonnet (via OpenRouter)</option>
  
  <!-- Open Source Models -->
  <option value="mistralai/mixtral-8x7b-instruct">Mixtral 8x7B (via OpenRouter)</option>
  <option value="meta-llama/llama-3-70b-chat">Llama 3 70B (via OpenRouter)</option>
</select>
```

And add a provider selector:
```html
<select name="ai_provider">
  <option value="openai">OpenAI (Direct)</option>
  <option value="openrouter">OpenRouter (Multi-Model)</option>
  <option value="deepseek">DeepSeek</option>
</select>
```

