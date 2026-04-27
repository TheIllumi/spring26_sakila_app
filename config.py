# ============================================
# Developer: Saad Mughal — Date: 27-04-2026
# Conflict resolved: kept sakila-db-server as host,
# included both CONNECTION_TIMEOUT and HEALTH_CHECK_INTERVAL
# ============================================

"""Configuration settings for the Sakila Flask application."""

import os


class Config:
    """Stores environment-based configuration values for the Flask app."""

    MYSQL_HOST = os.environ.get('MYSQL_HOST', 'sakila-db-server')
    MYSQL_USER = os.environ.get('MYSQL_USER', 'root')
    MYSQL_PASSWORD = os.environ.get('MYSQL_PASSWORD', 'admin')
    MYSQL_DB = os.environ.get('MYSQL_DB', 'sakila')

    try:
        CONNECTION_TIMEOUT = int(os.environ.get('CONNECTION_TIMEOUT', '30'))
    except ValueError:
        CONNECTION_TIMEOUT = 30

    try:
        HEALTH_CHECK_INTERVAL = int(os.environ.get('HEALTH_CHECK_INTERVAL', '10'))
    except ValueError:
        HEALTH_CHECK_INTERVAL = 10

    SECRET_KEY = os.environ.get(
        'SECRET_KEY',
        'your-secret-key-here-change-this-in-production'
    )