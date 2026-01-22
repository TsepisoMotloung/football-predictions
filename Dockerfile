FROM python:3.11-slim

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application
COPY . .

# Set environment
ENV PORT=8080
EXPOSE 8080

# Run Streamlit app
CMD exec streamlit run app.py \
  --server.port=${PORT} \
  --server.address=0.0.0.0 \
  --logger.level=error
