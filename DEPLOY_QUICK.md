# 🚀 Quick Deploy

## Vercel won't work for Streamlit apps (they need long-running servers)

But here are 3 SUPER EASY alternatives:

### ⭐ **Option 1: Streamlit Cloud (5 minutes - FREE)**

1. Push to GitHub
   ```bash
   git push origin main
   ```

2. Go to [share.streamlit.io](https://share.streamlit.io)

3. Click "New app" → Select your repo → Select `app.py`

4. Wait 2-3 minutes → Done! ✅

**Cost:** Free (with cool features)

---

### **Option 2: Railway (~10 minutes - $5-10/mo)**

1. Install Railway:
   ```bash
   npm install -g @railway/cli
   ```

2. Deploy:
   ```bash
   railway login
   railway init
   railway up
   ```

3. Add `FOOTYSTATSAPI` in Railway dashboard

**Cost:** Pay-per-use (~$5-10/month)

---

### **Option 3: Render.com (10 minutes - FREE with limits)**

1. Go to [render.com](https://render.com)

2. Click "New Web Service" → Connect GitHub

3. Set:
   - **Build:** `pip install -r requirements.txt`
   - **Start:** `streamlit run app.py --server.port 10000 --server.address 0.0.0.0`

4. Add env var: `FOOTYSTATSAPI=your_key`

**Cost:** Free tier available (spins down after 15 mins)

---

## Why not Vercel?

Vercel is for:
- Static websites ✅
- Serverless functions (quick requests) ✅

But NOT for:
- Streamlit apps (long-running Python servers) ❌
- WebSocket connections ❌
- Background jobs ❌

---

## My Recommendation

| If you want | Use |
|-----------|-----|
| **Easiest** | Streamlit Cloud |
| **24/7 always-on** | Railway |
| **Completely free** | Render (with limits) |
| **Production scale** | Docker + Google Cloud Run |

---

## Need Help?

Run the deployment helper:
```bash
./deploy.sh
```

Or read full guide:
```bash
cat DEPLOYMENT_GUIDE.md
```
