#!/bin/bash

# Football Prediction System - Deployment Helper
# Choose your deployment platform and follow the steps

echo "==============================================="
echo "⚽ Football Prediction System - Deployment"
echo "==============================================="
echo ""
echo "Select your deployment platform:"
echo ""
echo "1) Streamlit Cloud (⭐ Recommended - Free & Easy)"
echo "2) Railway.app (24/7 uptime, ~\$5-10/mo)"
echo "3) Render.com (Free tier available)"
echo "4) Google Cloud Run (Pay-per-use, cheapest at scale)"
echo "5) Docker Local Test (Test Docker image locally)"
echo "6) View deployment guide"
echo ""
read -p "Enter your choice (1-6): " choice

case $choice in
    1)
        echo ""
        echo "📚 Streamlit Cloud Deployment"
        echo "================================"
        echo ""
        echo "Step 1: Push to GitHub"
        echo "  git add ."
        echo "  git commit -m 'Ready for production'"
        echo "  git push origin main"
        echo ""
        echo "Step 2: Go to https://share.streamlit.io"
        echo "Step 3: Sign in with GitHub"
        echo "Step 4: Click 'New app'"
        echo "Step 5: Select repository, branch (main), file (app.py)"
        echo "Step 6: Click Deploy!"
        echo ""
        echo "Step 7: Add secrets in dashboard"
        echo "  Settings → Secrets"
        echo "  FOOTYSTATSAPI = your_key"
        echo ""
        echo "✅ Your app will be live in 2-3 minutes!"
        ;;
    2)
        echo ""
        echo "🚂 Railway Deployment"
        echo "====================="
        echo ""
        echo "Step 1: Install Railway CLI"
        echo "  npm install -g @railway/cli"
        echo ""
        echo "Step 2: Login"
        echo "  railway login"
        echo ""
        echo "Step 3: Initialize project"
        echo "  railway init"
        echo ""
        echo "Step 4: Deploy"
        echo "  railway up"
        echo ""
        echo "Step 5: Add environment variables"
        echo "  railway service add DATABASE"
        echo "  Set FOOTYSTATSAPI in dashboard"
        echo ""
        echo "✅ Visit your railway project dashboard for live URL"
        ;;
    3)
        echo ""
        echo "🎨 Render.com Deployment"
        echo "========================"
        echo ""
        echo "Step 1: Go to https://render.com"
        echo "Step 2: Sign in with GitHub"
        echo "Step 3: Click 'New +' → 'Web Service'"
        echo "Step 4: Connect your repository"
        echo "Step 5: Configure:"
        echo "  Name: football-predictor"
        echo "  Build command: pip install -r requirements.txt"
        echo "  Start command: streamlit run app.py --server.port 10000 --server.address 0.0.0.0"
        echo "Step 6: Add environment variable:"
        echo "  FOOTYSTATSAPI = your_key"
        echo ""
        echo "✅ Deploy and get live URL"
        ;;
    4)
        echo ""
        echo "☁️  Google Cloud Run Deployment"
        echo "================================"
        echo ""
        echo "Step 1: Install Google Cloud CLI"
        echo "  curl https://sdk.cloud.google.com | bash"
        echo ""
        echo "Step 2: Login"
        echo "  gcloud auth login"
        echo ""
        echo "Step 3: Deploy"
        echo "  gcloud run deploy football-predictor \\"
        echo "    --source . \\"
        echo "    --platform managed \\"
        echo "    --region us-central1 \\"
        echo "    --set-env-vars FOOTYSTATSAPI=your_key \\"
        echo "    --allow-unauthenticated"
        echo ""
        echo "✅ You'll get a live URL in the output"
        ;;
    5)
        echo ""
        echo "🐳 Testing Docker Locally"
        echo "=========================="
        echo ""
        echo "Building Docker image..."
        docker build -t football-predictor .
        
        if [ $? -eq 0 ]; then
            echo ""
            echo "✅ Build successful!"
            echo ""
            echo "Run locally with:"
            echo "  docker run -p 8501:8080 -e FOOTYSTATSAPI=test85g57 football-predictor"
            echo ""
            echo "Then visit: http://localhost:8501"
        else
            echo "❌ Build failed. Check Docker installation."
        fi
        ;;
    6)
        echo ""
        echo "Opening deployment guide..."
        if command -v cat &> /dev/null; then
            cat DEPLOYMENT_GUIDE.md
        else
            echo "See DEPLOYMENT_GUIDE.md for detailed instructions"
        fi
        ;;
    *)
        echo "Invalid choice. Please run again and select 1-6."
        exit 1
        ;;
esac

echo ""
echo "Questions? Check DEPLOYMENT_GUIDE.md for more details"
echo ""
