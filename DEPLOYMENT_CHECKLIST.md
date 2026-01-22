# Pre-Deployment Checklist ✅

## Code & Files
- [x] `app.py` - Main Streamlit application
- [x] `today_matches.py` - API fetching script
- [x] `fetch_data.py` - Feature extraction
- [x] `predict.py` - ML predictions
- [x] `requirements.txt` - All dependencies listed
- [x] `.env` - Environment variables template (DON'T commit!)
- [x] `.gitignore` - Includes .env, CSV files, __pycache__

## Configuration Files
- [x] `.streamlit/config.toml` - Streamlit settings
- [x] `Procfile` - For Heroku/Railway deployments
- [x] `Dockerfile` - For container deployments
- [x] `.dockerignore` - Files to exclude from Docker

## ML Models
- [x] `ridge_home_model.pkl` - Home team predictions model
- [x] `ridge_away_model.pkl` - Away team predictions model
- [x] `scaler_new.pkl` - Feature scaler

## Documentation
- [x] `README.md` - Project overview
- [x] `DEPLOYMENT_GUIDE.md` - Detailed deployment instructions
- [x] `DEPLOY_QUICK.md` - Quick start guide
- [x] `QUICK_START.md` - User guide

## Before Deploying

### 1. Test Locally ✅
```bash
# Make sure app runs without errors
streamlit run app.py
```

### 2. Commit All Changes ✅
```bash
git add .
git commit -m "Production ready"
git push origin main
```

### 3. Verify API Key ✅
- [ ] API key set in `.env` (test locally)
- [ ] `.env` is in `.gitignore` (don't commit!)
- [ ] Plan to add secrets in production platform

### 4. Check Requirements ✅
```bash
# Make sure all dependencies are in requirements.txt
pip freeze > requirements.txt
```

### 5. Test with Fresh Data ✅
```bash
# Delete old CSV files
rm -f live.csv extracted_features_complete.csv best_match_predictions.csv

# Run full pipeline
python today_matches.py
python fetch_data.py
python predict.py

# Verify predictions generated
streamlit run app.py
```

## Deployment Steps

### Choose Your Platform

**Streamlit Cloud** (Easiest)
- [ ] Push to GitHub
- [ ] Go to share.streamlit.io
- [ ] Connect repository
- [ ] Add secrets (FOOTYSTATSAPI)
- [ ] Deploy!

**Railway.app** (Always-on)
- [ ] Install railway CLI
- [ ] Run `railway login` && `railway init` && `railway up`
- [ ] Add FOOTYSTATSAPI env var
- [ ] Check railway.app dashboard for URL

**Render.com** (Free option)
- [ ] Go to render.com
- [ ] Create Web Service
- [ ] Configure build/start commands
- [ ] Add FOOTYSTATSAPI env var
- [ ] Deploy!

**Docker + Google Cloud** (Professional)
- [ ] Test locally: `docker build -t football-predictor .`
- [ ] Install Google Cloud CLI
- [ ] Run `gcloud run deploy` command
- [ ] Get live URL

## After Deployment

### Test Live App
- [ ] Homepage loads without errors
- [ ] Stats cards show correct numbers
- [ ] Can see predictions table
- [ ] Download buttons work
- [ ] Can click through tabs

### Verify Data Pipeline
- [ ] Click "Run Full Pipeline"
- [ ] Watch it fetch, extract, and predict
- [ ] Verify 10 matches loaded
- [ ] Check predictions display team names

### Monitor Performance
- [ ] Check deployment logs for errors
- [ ] Monitor response time (should be <2 seconds for repeat views)
- [ ] Watch for any API errors

## Troubleshooting

### App won't deploy?
1. Check `requirements.txt` has all dependencies
2. Verify Python version (should be 3.8+)
3. Check deployment logs for specific errors

### App crashes after deploy?
1. Look at platform logs (Streamlit Cloud, Railway, etc.)
2. Test locally first with `streamlit run app.py`
3. Verify all environment variables are set

### API key not working?
1. Check it's in secrets, not hardcoded
2. Verify exact value (no extra spaces)
3. Try test key: `test85g57`

### Data not updating?
1. Pipeline clears old CSV files on each run
2. First run can take 10-15 seconds
3. Check API limits (unlikely with test key)

### Takes forever to load?
1. Cold start (first request wakes app) - normal first time
2. Streamlit Cloud free tier sleeps after 1 hour inactivity
3. Consider paid tier for always-on

## Success! 🎉

Your app is now live! Share the URL with:
- [ ] Team members
- [ ] Stakeholders
- [ ] Users

## Performance Notes

**Expected behavior:**
- First load: 5-10 seconds (cold start)
- Subsequent loads: 1-2 seconds
- Full pipeline run: 15-20 seconds (fetch + extract + predict)

**Limits to know:**
- Streamlit Cloud free: 1 GB RAM, sleeps after 1 hour
- Railway: ~0.5 cents per GB-hour
- Google Cloud Run: ~$0.40/month at low usage

## Need More Help?

- `DEPLOYMENT_GUIDE.md` - Full deployment details
- `DEPLOY_QUICK.md` - Quick start
- `QUICK_START.md` - User guide
- `README.md` - Project overview

Good luck! 🚀
