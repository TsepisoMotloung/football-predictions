# Football Prediction System - Deployment Guide

## Quick Comparison

| Platform | Cost | Setup Time | Best For |
|----------|------|-----------|----------|
| **Streamlit Cloud** ⭐ | Free (generous limits) | 5 mins | Easiest, recommended |
| **Railway** | Pay-per-use (~$5-10/mo) | 10 mins | Good for 24/7 apps |
| **Render** | Free tier available | 10 mins | Simple deployments |
| **Docker + Google Cloud Run** | Pay-per-use | 20 mins | Scalable |
| **Heroku** ❌ | No free tier | - | Deprecated for free |

---

## Option 1: Streamlit Cloud (⭐ Recommended - Easiest)

### Step 1: Push to GitHub
```bash
git add .
git commit -m "Production ready"
git push origin main
```

### Step 2: Connect to Streamlit Cloud
1. Go to [share.streamlit.io](https://share.streamlit.io)
2. Sign in with GitHub
3. Click "New app"
4. Select your repository, branch, and main file (`app.py`)
5. Deploy!

### Step 3: Configure Secrets
In Streamlit Cloud dashboard, go to "Settings" → "Secrets" and add:
```toml
FOOTYSTATSAPI = "your_api_key_here"
```

**Pros:**
- Free tier with good limits (1 GB RAM)
- Auto-deploys on git push
- Perfect for Streamlit apps
- No credit card needed for free tier

**Cons:**
- App sleeps after 1 hour of inactivity (free tier)
- Limited to Streamlit apps only

---

## Option 2: Railway.app (Better for 24/7)

### Step 1: Install Railway CLI
```bash
npm install -g @railway/cli
# or
curl -fsSL railway.sh | sh
```

### Step 2: Create Procfile
```bash
echo "web: streamlit run app.py --server.port \$PORT --server.address 0.0.0.0" > Procfile
```

### Step 3: Deploy
```bash
railway login
railway init
railway up
```

### Step 4: Add Environment Variables
In Railway dashboard:
- `FOOTYSTATSAPI` = your API key
- `PORT` = 8501 (optional)

**Pros:**
- 24/7 uptime
- Pay only for what you use (~$5-10/month)
- Easy horizontal scaling
- Good free tier for testing

**Cons:**
- Needs credit card (though free tier exists)
- Slightly more setup than Streamlit Cloud

---

## Option 3: Render.com

### Step 1: Create `render.yaml`
```yaml
services:
  - type: web
    name: football-predictor
    env: python
    plan: free
    buildCommand: pip install -r requirements.txt
    startCommand: streamlit run app.py --server.port 10000 --server.address 0.0.0.0
    envVars:
      - key: FOOTYSTATSAPI
        scope: run
        value: your_api_key
```

### Step 2: Push & Connect
1. Push code to GitHub
2. Go to [render.com](https://render.com)
3. Sign in with GitHub
4. Create new "Web Service"
5. Deploy!

**Pros:**
- Free tier available
- Simple setup
- Good uptime

**Cons:**
- Free tier spins down after 15 mins of inactivity
- Limited free resources

---

## Option 4: Docker + Google Cloud Run (Most Professional)

### Step 1: Create Dockerfile
```dockerfile
FROM python:3.11-slim

WORKDIR /app
COPY . .
RUN pip install -r requirements.txt

EXPOSE 8080
CMD exec streamlit run app.py \
  --server.port=${PORT:-8080} \
  --server.address=0.0.0.0 \
  --logger.level=error
```

### Step 2: Create `.dockerignore`
```
.git
.gitignore
README.md
*.pyc
__pycache__
.streamlit
.venv
```

### Step 3: Deploy
```bash
# Install Google Cloud CLI
curl https://sdk.cloud.google.com | bash

# Login
gcloud auth login

# Build and deploy
gcloud run deploy football-predictor \
  --source . \
  --platform managed \
  --region us-central1 \
  --set-env-vars FOOTYSTATSAPI=your_key \
  --allow-unauthenticated
```

**Pros:**
- Professional infrastructure
- Auto-scaling
- Pay per invocation (~$0.40/mo for light use)
- 2 million requests/month free

**Cons:**
- Slightly complex setup
- Overkill for small projects

---

## Pre-Deployment Checklist

- [ ] Add `requirements.txt` in repo root:
```
streamlit==1.53.0
pandas==2.0.3
scikit-learn==1.3.0
requests==2.31.0
python-dotenv==1.0.0
```

- [ ] Create `.streamlit/config.toml`:
```toml
[server]
port = 8501
headless = true
logger.level = "error"

[client]
showErrorDetails = false

[theme]
primaryColor = "#81D4FA"
backgroundColor = "#FFFFFF"
secondaryBackgroundColor = "#E0F2F1"
textColor = "#263238"
font = "sans serif"
```

- [ ] Update `.env.example`:
```
FOOTYSTATSAPI=your_test_key_here
```

- [ ] Add `.gitignore`:
```
.env
*.pyc
__pycache__
.streamlit/secrets.toml
live.csv
extracted_features_complete.csv
best_match_predictions.csv
```

---

## Production Environment Setup

### Set API Key Securely
**Local Development:**
```bash
echo "FOOTYSTATSAPI=your_key" > .env
```

**Production (Streamlit Cloud):**
1. Dashboard → Settings → Secrets
2. Add: `FOOTYSTATSAPI = "your_key"`

**Production (Other platforms):**
Set via environment variables in platform dashboard, NOT in code.

---

## Monitoring & Logs

### Streamlit Cloud
- Built-in logs in dashboard
- Performance metrics available

### Railway/Render/Cloud Run
- Check platform dashboard for logs
- Set up email alerts for errors

---

## Cost Estimates (Monthly)

| Platform | Free Tier | Cost @ 100 users |
|----------|-----------|-----------------|
| Streamlit Cloud | Included | Free* |
| Railway | $5 credit | $8-12 |
| Render | Free (limited) | $5-7 |
| Google Cloud Run | $11.50 credit | $2-5 |

*Streamlit Cloud paid tier: $5/app/month for always-on

---

## Recommended Setup

**For Development/Testing:**
→ Streamlit Cloud (free tier)

**For Small Production (< 1000 users/day):**
→ Railway.app or Render.com ($5-10/mo)

**For High Traffic:**
→ Google Cloud Run or AWS

---

## Next Steps

1. **Push to GitHub** (if not already):
```bash
git remote add origin https://github.com/yourusername/football-predictions.git
git push -u origin main
```

2. **Choose platform** from above

3. **Deploy** following the platform guide

4. **Test** with the live link

5. **Share** with users!

---

## Troubleshooting

**App crashes on deploy?**
- Check requirements.txt includes all dependencies
- Verify environment variables are set
- Check logs in platform dashboard

**Takes too long to respond?**
- Might be cold start (first request wakes up app)
- Consider paid tier for always-on

**API key not working?**
- Verify key in secrets manager (not hardcoded!)
- Check API rate limits
- Try test key: `test85g57`

**Data files missing?**
- Pipeline clears CSV files on each run
- First run generates fresh data
- Allows ~5-10 second processing time

---

## Support

- Streamlit Docs: https://docs.streamlit.io/deploy
- Railway Docs: https://docs.railway.app
- Render Docs: https://render.com/docs
- Google Cloud Run: https://cloud.google.com/run/docs

